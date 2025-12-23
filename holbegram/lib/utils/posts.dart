// task 10: posts.dart

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';


class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final Users? currentUser = userProvider.user;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.docs;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final post = data[index];

            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 540,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(post['profImage']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(post['username']),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Post Deleted'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(post['caption']),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: NetworkImage(post['postUrl']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Aquí puedes agregar los íconos de like, comentar, guardar, etc.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.comment_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.send_outlined),
                          onPressed: () {},
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../screens/pages/methods/post_storage.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    // Obtener usuario actual
    final user = Provider.of<UserProvider>(context).user;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('datePublished', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final posts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index].data() as Map<String, dynamic>;
            final String username = (post['username'] ?? '').toString();
            final String caption = (post['caption'] ?? '').toString();
            final String postUrl = (post['postUrl'] ?? '').toString();
            final String profImage = (post['profImage'] ?? '').toString();
            final List likes = (post['likes'] is List) ? post['likes'] as List : [];
            final String postId = (post['postId'] ?? posts[index].id).toString();
            final String publicId = (post['publicId'] ?? '').toString();

            return Container(
              margin: const EdgeInsets.all(8),
              height: 540,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  // HEADER
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          clipBehavior: Clip.antiAlias,
                          child: (profImage.isEmpty || !profImage.startsWith('http'))
                              ? const Icon(Icons.person)
                              : Image.network(
                                  profImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.person),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        // DELETE POST
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () async {
                            try {
                              await PostStorage().deletePost(postId, publicId);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Post Deleted")),
                              );
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Delete error: $e")),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  // CAPTION
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(caption),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // IMAGE
                  Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: (postUrl.isEmpty || !postUrl.startsWith('http'))
                        ? const Center(child: Icon(Icons.image))
                        : Image.network(
                            postUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Center(child: Icon(Icons.image)),
                          ),
                  ),

                  // ACTION ICONS
                  Row(
                    children: [
                      // LIKE
                      IconButton(
                        icon: Icon(
                          (user != null && likes.contains(user.uid))
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: (user != null && likes.contains(user.uid))
                              ? Colors.red
                              : Colors.black,
                        ),
                        onPressed: user == null
                            ? null
                            : () async {
                                try {
                                  await FirestoreMethods().likePost(
                                    postId: postId,
                                    uid: user.uid,
                                    likes: likes,
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              },
                      ),
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      // BOOKMARK
                      if (user == null)
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: null,
                        )
                      else
                        StreamBuilder<bool>(
                          stream: FirestoreMethods().isPostSaved(
                            uid: user.uid,
                            postId: postId,
                          ),
                          builder: (context, snap) {
                            final isSaved = snap.data ?? false;
                            return IconButton(
                              icon: Icon(
                                isSaved ? Icons.bookmark : Icons.bookmark_border,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                try {
                                  await FirestoreMethods().toggleSavePost(
                                    uid: user.uid,
                                    postId: postId,
                                    postUrl: postUrl,
                                  );
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isSaved ? "Removed from Favorites" : "Saved to Favorites",
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Save error: $e")),
                                  );
                                }
                              },
                            );
                          },
                        ),
                    ],
                  ),

                  // LIKES count
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${likes.length} Liked',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

