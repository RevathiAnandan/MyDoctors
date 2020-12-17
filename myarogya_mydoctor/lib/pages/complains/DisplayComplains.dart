import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/complains/MyComplainList.dart';

import 'NewComplains.dart';

class DisplayComplains extends StatelessWidget {
  List<Widget> categories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.add,color: Colors.redAccent),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>MyComplainList(),
                ),
              );
            },),
        ],
        title: Text("My Complains",
            style: TextStyle(
                color: Colors.redAccent,
                fontFamily: "Lato",
                fontSize: 20)),
      ),
      body: Container(),
      // body: PageView.builder(
      //     scrollDirection: Axis.vertical,
      //     itemBuilder: (context, position) {
      //       return Container(
      //         color: Colors.black,
      //         child: Stack(
      //           // children: <Widget>[AppVideoPlayer(), onScreenControls()],
      //         ),
      //       );
      //     },
      //     itemCount: 10),
    );
  }
}
