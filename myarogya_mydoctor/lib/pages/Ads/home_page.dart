import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/onscreen_controls.dart';
import 'package:myarogya_mydoctor/pages/widget/home/home_video_renderer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return Container(
            color: Colors.black,
            child: Stack(
              children: <Widget>[AppVideoPlayer(), onScreenControls()],
            ),
          );
        },
        itemCount: 10);
  }
}
