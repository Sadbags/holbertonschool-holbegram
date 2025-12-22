// task 10 add_image.dart

// lib/screens/pages/add_image.dart

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../resources/cloudinary_methods.dart';
import 'feed.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? _imageBytes;
  bool _isLoading = false;
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (file == null) return;

    final bytes = await file.readAsBytes();

    setState(() {
      _imageBytes = bytes;
    });
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
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _post() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in")),
      );
      return;
    }

    if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select an image first")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final postId = const Uuid().v4();
      final postUrl = await CloudinaryMethods().uploadPostImage(_imageBytes!);

      String username = user.email ?? 'user';
      String profImage = '';

      final userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userSnap.exists && userSnap.data() != null) {
        final data = userSnap.data()!;
        username = (data['username'] ?? username).toString();
        profImage = (data['photoUrl'] ?? '').toString();
      }

      await FirebaseFirestore.instance.collection('posts').doc(postId).set({
        "caption": _captionController.text.trim(),
        "uid": user.uid,
        "username": username,
        "likes": [],
        "postId": postId,
        "datePublished": Timestamp.now(),
        "postUrl": postUrl,
        "profImage": profImage,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post published ✅")),
      );

      // Reset
      setState(() {
        _imageBytes = null;
        _captionController.clear();
      });

      // 🔹 Redirigir a la pantalla Home / Feed
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Feed()),
      );

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Add Image",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: (_isLoading || _imageBytes == null) ? null : _post,
            child: _isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    "Post",
                    style: TextStyle(
                      fontFamily: "Billabong",
                      fontSize: 26,
                      color: Color(0xFFE57373),
                    ),
                  ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Add Image",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Choose an image from your gallery or take a one.",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: "Write a caption...",
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _isLoading ? null : _showPickOptions,
            child: Container(
              width: double.infinity,
              height: 260,
              color: const Color(0xFFF2F2F2),
              child: Center(
                child: _imageBytes == null
                    ? Image.asset(
                        'assets/icons/add.png',
                        width: 160,
                        height: 160,
                        fit: BoxFit.contain,
                      )
                    : Image.memory(
                        _imageBytes!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
