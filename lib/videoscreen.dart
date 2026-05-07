import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoScreen extends StatefulWidget {
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final List<String> videos = [
    "https://iframe.mediadelivery.net/embed/427063/ae05efcc-d6c2-4ba3-8c7f-62eea0b8d82b",
    "https://iframe.mediadelivery.net/embed/427063/3a6106d7-c4a4-4f3d-a446-e61c27869990",
    "https://iframe.mediadelivery.net/embed/427063/77c8e234-8f5f-4875-8fd3-787cb7dcc4e0",
  ];

  late WebViewController controller;
  String currentVideo = "";

  @override
  void initState() {
    super.initState();

    currentVideo = videos[0];

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(currentVideo));

    // Allow both portrait + landscape (for fullscreen)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void loadVideo(String url) {
    setState(() {
      currentVideo = url;
      controller.loadRequest(Uri.parse(url));
    });
  }

  @override
  void dispose() {
    // Lock back to portrait when leaving
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body: Column(
        children: [
          // 🎬 Video Player
          AspectRatio(
            aspectRatio: 16 / 9,
            child: WebViewWidget(controller: controller),
          ),

          const SizedBox(height: 10),

          // 📺 Video List
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.play_circle),
                  title: Text("Video ${index + 1}"),
                  onTap: () => loadVideo(videos[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}