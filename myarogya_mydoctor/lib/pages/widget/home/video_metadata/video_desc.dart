import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/complains.dart';

Widget videoDesc(Complains complains) {
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
      ],
    ),
  );
}
