import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../methods/auth_methods.dart';
import 'home.dart';


class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;
  bool _isLoading = false;

  final AuthMethode _authMethods = AuthMethode();

  void selectImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() => _image = bytes);
    }
  }

  void selectImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() => _image = bytes);
    }
  }

  void signUpUser() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() => _isLoading = true);

    String res = await _authMethods.signUpUser(
      email: widget.email,
      username: widget.username,
      password: widget.password,
      file: _image,
    );

    setState(() => _isLoading = false);

    if (res == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User registered successfully!')),
      );
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Home()),
    );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
    }
  }

  // task 7: upload picture
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Nombre de la app con Billabong
              const Text(
                'Holbegram',
                style: TextStyle(
                  fontFamily: 'Billabong',
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 10),

              // Logo Seahorse debajo del texto
              Image.asset(
                'assets/images/seahorse.png', // verifica que exista
                width: 80,
                height: 60,
              ),
              const SizedBox(height: 20),

              // Saludo
              Text(
                'Hello, ${widget.username}! Choose an image from your gallery or take a new one.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Avatar
              CircleAvatar(
                radius: 60,
                backgroundImage: _image != null ? MemoryImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
              const SizedBox(height: 20),

              // Botones cámara y galería
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 32),
                    onPressed: selectImageFromCamera,
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.photo, size: 32),
                    onPressed: selectImageFromGallery,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Botón Next
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : signUpUser,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
