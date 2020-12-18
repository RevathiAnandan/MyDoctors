import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Ads.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final String path;
  AppVideoPlayer(this.path);
  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        widget.path)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.initialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(
              color: Colors.black,
              child: Center(
                child: Container(
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}
