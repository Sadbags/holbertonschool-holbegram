// task 10: feed.dart

import 'package:flutter/material.dart';
import '../../utils/posts.dart';
import 'add_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  static const red = Color(0xFFD94335);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 12),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 38,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset('assets/images/seahorse.png', height: 26),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              // onPressed: () {},
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddImage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/chat_square_lines.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
      body: const Posts(),
    );
  }
}
