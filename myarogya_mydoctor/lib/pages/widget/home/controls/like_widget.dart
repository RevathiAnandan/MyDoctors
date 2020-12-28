import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:myarogya_mydoctor/model/complains.dart';
import 'package:myarogya_mydoctor/pages/complains/MyComplainList.dart';
import 'package:myarogya_mydoctor/resources/dimen.dart';
FirebaseDatabase fb = FirebaseDatabase.instance;
Widget likeWidget({IconData icon, String label,String complainKey,int type}) {
  return Padding(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: Column(
      children: <Widget>[
        LikeButton(
          size: 20,
          circleColor:
          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          onTap: (bool isliked){
            return onLikebuttonTap(isliked,complainKey,label);
          },
          likeBuilder: (bool isLiked) {
            return Icon(
              icon,
              color: isLiked ? Colors.white : Colors.white,
              size: 20,
            );
          },
          likeCount: type,
          countBuilder: (int count, bool isLiked, String text) {
            var color = isLiked ? Colors.white : Colors.white;
            count = type;
            Widget result;
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            // print(result);
            return result;
          },
        ),
      ],
    ),
  );
}

Future<bool> onLikebuttonTap(bool isLiked,String complainKey,String label)async{
  var ref = fb.reference().child("MyComplains/$complainKey/$label");
  !isLiked?ref.once().then((data)async=>{
    await ref.set(data.value+1),
  }):ref.once().then((data)async=>{
    await ref.set(data.value+-1),
  });
  return !isLiked;
}




