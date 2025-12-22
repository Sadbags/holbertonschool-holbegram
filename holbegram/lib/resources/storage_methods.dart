import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  Future<String> uploadImageToStorage({
    required Uint8List file,
    required String uid,
    required String folder,
    String? fileName, // ex: postId
  }) async {
    try {
      final String id = fileName ?? _uuid.v4();
      final Reference ref = _storage.ref().child(folder).child(uid).child('$id.jpg');

      final TaskSnapshot snap = await ref.putData(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final String url = await snap.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw Exception('[FirebaseStorage:${e.code}] ${e.message}');
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }

  Future<String> uploadPostImage({
    required Uint8List file,
    required String uid,
    String? postId,
  }) async {
    return uploadImageToStorage(
      file: file,
      uid: uid,
      folder: 'posts',
      fileName: postId,
    );
  }
}
