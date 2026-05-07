import 'package:flutter/material.dart';
import 'package:newtask/data/videolist.dart';
import '../data/videolist.dart';
import 'playerscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.play_circle),
            title: Text("Video ${index + 1}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlayerScreen(url: videoUrls[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}