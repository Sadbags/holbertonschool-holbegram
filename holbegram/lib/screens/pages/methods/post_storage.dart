// tasks 11: post_storage.dart

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../auth/methods/user_storege.dart';


class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String caption,
    String uid,
    String username,
    String profImage,
    Uint8List image,
  ) async {
    try {
      final String postId = const Uuid().v4();

      final data = await UserStorege().uploadImageToCloudinary(
        image,
        folder: "holbegram/posts",
        publicId: postId,
      );

      final String postUrl = (data["secure_url"] ?? "").toString();
      final String publicId = (data["public_id"] ?? "").toString();

      await _firestore.collection("posts").doc(postId).set({
        "caption": caption.trim(),
        "uid": uid,
        "username": username,
        "likes": [],
        "postId": postId,
        // "datePublished": Timestamp.now(),
		"datePublished": FieldValue.serverTimestamp(),
        "postUrl": postUrl,
        "profImage": profImage,
        "publicId": publicId,
      });

      return "Ok";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deletePost(String postId, String publicId) async {
    await _firestore.collection("posts").doc(postId).delete();
  }
}
