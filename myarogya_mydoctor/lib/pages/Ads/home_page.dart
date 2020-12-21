import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Ads.dart';
import 'package:myarogya_mydoctor/pages/Ads/addAds.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/appBarControls.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/onscreen_controls.dart';
import 'package:myarogya_mydoctor/pages/widget/home/home_video_renderer.dart';

import 'addcampaign.dart';

class HomeScreen extends StatefulWidget {

  final String id;
  final String mobile;
  HomeScreen(this.id, this.mobile);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseDatabase fb = FirebaseDatabase.instance;
  List<MyAds> myads = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getads();
  }


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
                  builder: (context) =>AdsUserProfile(widget.id,widget.mobile),
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
              color: Colors.black.withOpacity(0.6),
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                // children: <Widget>[ myads[position].video==""?Image.network(myads[position].image):AppVideoPlayer(myads[position].video), onScreenControls(myads[position])],
              ),
            );
          },
          itemCount: myads.length),
    );
  }
  Future<MyAds> getads() async{
    await fb.reference().child("MyAds").once().then((DataSnapshot snapshot) {
      print(snapshot);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = MyAds.fromJson(values);
          print(refreshToken.mobile);
          myads.add(refreshToken);
          print(myads.toString());
          setState(() {
            isLoading =false;
          });
        });
        print(isLoading.toString());
      }
    });
  }
}
