import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Ads.dart';
import 'package:myarogya_mydoctor/model/complains.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/like_widget.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/video_control_action.dart';

Widget videoDesc(Complains complains,String complainKey) {
  return Container(
    padding: EdgeInsets.only(left: 16, bottom: 60),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 7, bottom: 7),
          child: Text(
           "Complain Number: "+complains.ComplainNumber,
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 7),
          child: Text(
              "About: "+complains.About,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300)),
        ),
        Row(
          children: <Widget>[
            Text(
              "Category: "+complains.Category,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
        Divider(
          height: 10,
          color: Colors.white,
          thickness: 0.5,
        ),
        Row(
          children: [
            // InkWell(
            //   onTap: (){
            //     complains.Risky=complains.Risky+1;
            //   },
            //   child: Row(
            //     children: [
            //       Icon(Icons.nature,color: Colors.white,),
            //       Text("Risky"+complains.Risky.toString(),style: TextStyle(color: Colors.white),),
            //     ],
            //   ),
            // ),

            Flexible(flex:5,child: likeWidget(icon: Icons.nature,label: "Risky",complainKey:complainKey,type: complains.Risky)),
            Flexible(flex:5,child: likeWidget(icon: Icons.info,label: "Urgent",complainKey:complainKey,type: complains.Urgent)),
            Flexible(flex:5,child: likeWidget(icon: Icons.view_array,label: "Priority",complainKey:complainKey,type: complains.Priority)),

            Flexible(flex:5,child: videoControlAction(icon: Icons.remove_red_eye_outlined, label: complains.Views.toString())),
          ],
        )
      ],
    ),
  );
}
Widget videoDescA(MyAds ads) {
  return Container(
    padding: EdgeInsets.only(left: 16, bottom: 60),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 7, bottom: 7),
          child: Text(
            ads.name,
           // "Complain Number: "+ads.ComplainNumber,
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 7),
          child: Text(
              ads.slogan,
              // "About: "+complains.About,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300)),
        ),
        Row(
          children: <Widget>[
            Text(
              ads.productCatogory,
              // "Category: "+complains.Category,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      ],
    ),
  );
}
