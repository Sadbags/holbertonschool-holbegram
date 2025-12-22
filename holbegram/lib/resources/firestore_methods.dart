import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> likePost({
    required String postId,
    required String uid,
    required List likes,
  }) async {
    try {
      final postRef = _firestore.collection('posts').doc(postId);

      if (likes.contains(uid)) {
        await postRef.update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await postRef.update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //  tasks 14: save / unsave bookmarks
  Future<void> toggleSavePost({
    required String uid,
    required String postId,
    required String postUrl,
  }) async {
    try {
      final savedRef = _firestore
          .collection('users')
          .doc(uid)
          .collection('savedPosts')
          .doc(postId);

      final snap = await savedRef.get();

      if (snap.exists) {
        // unsave
        await savedRef.delete();
      } else {
        // save
        await savedRef.set({
          'postId': postId,
          'postUrl': postUrl,
          'savedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<bool> isPostSaved({
    required String uid,
    required String postId,
  }) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('savedPosts')
        .doc(postId)
        .snapshots()
        .map((doc) => doc.exists);
  }
}