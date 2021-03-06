import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/animations/spinner_animation.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/video_control_action.dart';
import 'package:myarogya_mydoctor/pages/widget/home/video_metadata/user_profile.dart';
import 'package:myarogya_mydoctor/pages/widget/home/video_metadata/video_desc.dart';
import 'package:myarogya_mydoctor/resources/assets.dart';

import '../audio_spinner_icon.dart';
Widget appBarControls() {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(flex: 5, child: Text("My Ads",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Lato",
                fontSize: 14)),),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(bottom: 60, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // userProfile(),
                // videoControlAction(icon: AppIcons.heart, label: "17.8k"),
                // videoControlAction(icon: AppIcons.chat_bubble, label: "130"),
                // videoControlAction(
                //     icon: AppIcons.reply, label: "Share", size: 27),
                // SpinnerAnimation(body: audioSpinner())
              ],
            ),
          ),
        )
      ],
    ),
  );
}
