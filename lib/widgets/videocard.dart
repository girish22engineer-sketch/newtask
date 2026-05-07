import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const VideoCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(Icons.play_circle, size: 40),
              const SizedBox(width: 15),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}