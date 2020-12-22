import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/animations/spinner_animation.dart';
import 'package:myarogya_mydoctor/model/complains.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/video_control_action.dart';
import 'package:myarogya_mydoctor/pages/widget/home/video_metadata/user_profile.dart';
import 'package:myarogya_mydoctor/pages/widget/home/video_metadata/video_desc.dart';
import 'package:myarogya_mydoctor/resources/assets.dart';

import '../audio_spinner_icon.dart';
import 'like_widget.dart';
Widget onScreenControls(Complains complains,String complainKey) {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(flex: 5, child: videoDesc(complains)),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(bottom: 60, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // userProfile(),
                // videoControlAction(icon: AppIcons.heart, label: "17.8k"),
                // InkWell(
                //   onTap: (){
                //     incrementcounter(complainKey);
                //   },
                //   child: Row(
                //     children: <Widget>[
                //       Icon(Icons.favorite),
                //       Text(complains.Risky.toString()
                //       ),
                //     ],
                //   ),
                // ),
                likeWidget(icon: Icons.nature,label: "Risky",complainKey:complainKey),
                likeWidget(icon: Icons.info,label: "Urgent",complainKey:complainKey),
                likeWidget(icon: Icons.view_array,label: "Priority",complainKey:complainKey),
                likeWidget(icon: Icons.view_list,label: "Views",complainKey:complainKey),
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

incrementcounter(String key) async{
  try {
    var ref = fb.reference().child("MyComplains/$key/Risky");
    await ref.once().then((data) async => {
      await ref.set(data.value + 1),
    });
  } catch (e) {
    print(e.message);
  }
}
