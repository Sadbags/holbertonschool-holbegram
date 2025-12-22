// task 10: profile_screen.dart

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/methods/user_storege.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _updatingPhoto = false;


  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  Future<void> _pickAndUpdatePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (file == null) return;

    setState(() => _updatingPhoto = true);

    try {
      final Uint8List bytes = await file.readAsBytes();

    final String publicId =
      "profile_${_uid}_${DateTime.now().millisecondsSinceEpoch}";
      final Map<String, dynamic> res =
          await UserStorege().uploadImageToCloudinary(bytes, folder: "profiles", publicId: publicId,);


      final String newUrl = (res['secure_url'] ?? res['url'] ?? '').toString();

      if (newUrl.isEmpty) {
        throw Exception("Cloudinary: secure_url is empty");
      }

      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'photoUrl': newUrl,
        'photoUpdatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile photo updated ✅")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _updatingPhoto = false);
    }
  }

  void _showPickOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickAndUpdatePhoto(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickAndUpdatePhoto(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Not logged in")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 32,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(_uid).snapshots(),
        builder: (context, userSnap) {
          if (userSnap.hasError) {
            return Center(child: Text("Error: ${userSnap.error}"));
          }
          if (!userSnap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final Map<String, dynamic> data =
              (userSnap.data!.data() as Map<String, dynamic>?) ?? {};

          final String username = (data['username'] ?? user.email ?? 'user').toString();
          final String photoUrl = (data['photoUrl'] ?? '').toString();

          final Timestamp? ts = data['photoUpdatedAt'] is Timestamp
              ? data['photoUpdatedAt'] as Timestamp
              : null;
          final String v = ts == null ? '' : ts.millisecondsSinceEpoch.toString();
          final String displayPhotoUrl =
              (photoUrl.isEmpty) ? '' : (v.isEmpty ? photoUrl : "$photoUrl?v=$v");

          return Column(
            children: [
              const SizedBox(height: 8),

              // Header profile
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    // Avatar
                    GestureDetector(
                      onTap: _updatingPhoto ? null : _showPickOptions,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF2F2F2),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: displayPhotoUrl.isEmpty
                                ? const Icon(Icons.person, size: 35, color: Colors.grey)
                                : Image.network(
                                    displayPhotoUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.person,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                          if (_updatingPhoto)
                            Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0x55FFFFFF),
                              ),
                              child: const Center(
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // (posts live)
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .where('uid', isEqualTo: _uid)
                                .snapshots(),
                            builder: (context, postsSnap) {
                              final int postsCount =
                                  postsSnap.hasData ? postsSnap.data!.docs.length : 0;

                              final List followersList =
                                  (data['followers'] is List) ? data['followers'] as List : [];
                              final List followingList =
                                  (data['following'] is List) ? data['following'] as List : [];

                              final int followers = followersList.length;
                              final int following = followingList.length;


                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _Stat(value: postsCount, label: "Posts"),
                                  _Stat(value: followers, label: "Followers"),
                                  _Stat(value: following, label: "Following"),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // (images Cloudinary)
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: _uid)
                      .orderBy('datePublished', descending: true)
                      .snapshots(),
                  builder: (context, postsSnap) {
                    if (postsSnap.hasError) {
                      return Center(child: Text("Error: ${postsSnap.error}"));
                    }
                    if (!postsSnap.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final docs = postsSnap.data!.docs;

                    if (docs.isEmpty) {
                      return const Center(child: Text("No posts yet"));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> post =
                            (docs[index].data() as Map<String, dynamic>?) ?? {};

                        final String url = (post['postUrl'] ?? '').toString();

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: const Color(0xFFF2F2F2),
                            child: (url.isEmpty || !url.startsWith('http'))
                                ? const Icon(Icons.image, color: Colors.grey)
                                : Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.image, color: Colors.grey),
                                  ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final int value;
  final String label;

  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          Text(
            "$value",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
