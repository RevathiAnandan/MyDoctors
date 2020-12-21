import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:myarogya_mydoctor/resources/dimen.dart';

Widget likeWidget({IconData icon, String label}) {
  return Padding(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: Column(
      children: <Widget>[
        LikeButton(
          size: 30,
          circleColor:
          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              icon,
              color: isLiked ? Colors.redAccent : Colors.grey,
              size: 30,
            );
          },
          likeCount: 0,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Colors.redAccent : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                label,
                style: TextStyle(color: color),
              );
            } else
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            return result;
          },
        ),
      ],
    ),
  );
}
