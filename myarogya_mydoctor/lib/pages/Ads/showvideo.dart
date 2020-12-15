import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class ShowVideoPlayer extends StatefulWidget {
  final File path;
  ShowVideoPlayer(this.path);

  @override
  _ShowVideoPlayerState createState() => _ShowVideoPlayerState();
}

class _ShowVideoPlayerState extends State<ShowVideoPlayer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}