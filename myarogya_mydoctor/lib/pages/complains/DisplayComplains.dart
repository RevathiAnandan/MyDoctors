import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/dropdownlists.dart';
import 'package:myarogya_mydoctor/model/complains.dart';
import 'package:myarogya_mydoctor/pages/complains/MyComplainList.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/onscreen_controls.dart';
import 'package:myarogya_mydoctor/pages/widget/home/home_video_renderer.dart';

import 'NewComplains.dart';

class DisplayComplains extends StatefulWidget {
  final String id;
  final String mobile;
  DisplayComplains(this.id, this.mobile);
  @override
  _DisplayComplainsState createState() => _DisplayComplainsState();
}

class _DisplayComplainsState extends State<DisplayComplains> {
  List<Widget> categories = [];

  FirebaseDatabase fb = FirebaseDatabase.instance;

  List<Complains> complain = [];
  List<String> complainKey = [];

  bool isLoading = true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComplains();
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
                  builder: (context) =>MyComplainList(widget.id,widget.mobile,complain),
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
      body: Row(
        children: [
          Flexible(
            flex: 5,
            child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, position) {
                  return Container(
                    color: Colors.black,
                    child: Stack(
                      children: <Widget>[complain[position].video==""?Image.network(complain[position].image):AppVideoPlayer(complain[position].video), onScreenControls(complain[position],complainKey[position])],
                    ),
                  );
                },
                itemCount: complain.length),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Center(child: Text("Issue Catogory"),),
                ),
                Flexible(
                  flex: 7,
                  child: ListView.builder(
                    itemCount: Dropdownlists().categories.length,
                    itemBuilder: (context,index){
                      return MaterialButton(
                        child: Text(Dropdownlists().categories[index],style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),),
                        onPressed: (){
                            filtercomplains(Dropdownlists().categories[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Complains> getComplains() async{
    await fb.reference().child("MyComplains").once().then((DataSnapshot snapshot) {
      print(snapshot);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Complains.fromJson(values);
          complain.add(refreshToken);
          complainKey.add(key);
          setState(() {
            isLoading =false;
          });
        });
        print(isLoading.toString());
      }
    });
  }

  Future<Complains> filtercomplains(String catogory) async{
    complain.clear();
    setState(() {
      isLoading =true;
    });
    await fb.reference().child("MyComplains").once().then((DataSnapshot snapshot) {
      print(snapshot);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Complains.fromJson(values);
          if (refreshToken.Category == catogory) {
            complain.add(refreshToken);
          }
          setState(() {
            isLoading = false;
          });
        });
        print(isLoading.toString());
      }
    });
  }
}
