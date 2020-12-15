import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/Ads/addAds.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/onscreen_controls.dart';
import 'package:myarogya_mydoctor/pages/widget/home/home_video_renderer.dart';

class HomeScreen extends StatelessWidget {
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
                  builder: (context) =>Addads(),
                ),
              );
            },),
        ],
        title: Text("My Ads",
            style: TextStyle(
                color: Colors.redAccent,
                fontFamily: "Lato",
                fontSize: 20)),
      ),
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, position) {
            return Container(
              color: Colors.black,
              child: Stack(
                children: <Widget>[AppVideoPlayer(), onScreenControls()],
              ),
            );
          },
          itemCount: 10),
    );
  }
}
