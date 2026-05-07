import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../data/videolist.dart';

class PlayerScreen extends StatefulWidget {
  final String url;

  const PlayerScreen({super.key, required this.url});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final WebViewController controller;

  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  // ✅ ENTER FULLSCREEN
  void enterFullScreen() {
    setState(() {
      isFullScreen = true;
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // ✅ EXIT FULLSCREEN
  void exitFullScreen() {
    setState(() {
      isFullScreen = false;
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    exitFullScreen(); // reset when leaving
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen
          ? null
          : AppBar(title: const Text("Player")),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: isFullScreen
                    ? MediaQuery.of(context).size.height
                    : 250,
                width: double.infinity,
                child: WebViewWidget(controller: controller),
              ),

              // 🔥 FULLSCREEN BUTTON
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(
                    isFullScreen
                        ? Icons.fullscreen_exit
                        : Icons.fullscreen,
                    size: 30,
                  ),
                  onPressed: () {
                    isFullScreen
                        ? exitFullScreen()
                        : enterFullScreen();
                  },
                ),
              ),
            ],
          ),

          // Hide list in fullscreen
          if (!isFullScreen)
            Expanded(
              child: ListView.builder(
                itemCount: videoUrls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Video ${index + 1}"),
                    onTap: () {
                      controller.loadRequest(
                        Uri.parse(videoUrls[index]),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}