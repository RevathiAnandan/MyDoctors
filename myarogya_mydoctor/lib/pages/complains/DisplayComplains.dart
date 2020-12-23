import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/dropdownlists.dart';
import 'package:myarogya_mydoctor/model/complains.dart';
import 'package:myarogya_mydoctor/pages/complains/ComplainResolution.dart';
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
                  builder: (context) =>NewComplains(widget.id,widget.mobile),
                ),
              );
            },),
          IconButton(icon: Icon(Icons.list,color: Colors.redAccent),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>MyComplainList(widget.id,widget.mobile,complain),
                ),
              );
            },),
          IconButton(icon: Icon(Icons.announcement,color: Colors.redAccent),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>ComplainResolution(widget.id,widget.mobile),
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
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                    child: Stack(
                      children: stackwidgets(position),
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
                  child: Center(child: Text("Issue Category"),),
                ),
                new Divider(
                  height: 10.0,
                  color: Colors.redAccent,
                ),
                Flexible(
                  flex: 7,
                  child: ListView.builder(
                    itemCount: Dropdownlists().categories.length,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          MaterialButton(
                            child: Text(Dropdownlists().categories[index],style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15.0,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),),
                            onPressed: (){
                                filtercomplains(Dropdownlists().categories[index]);
                            },
                          ),
                          new Divider(
                            height: 10.0,
                            color: Colors.redAccent,
                          ),
                        ],
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

  List<Widget> stackwidgets(position)  {
    incrementcounter(complainKey[position]);
    return [
      if(complain[position].video=="")
        Image.network(complain[position].image)
      else
        AppVideoPlayer(complain[position].video),
      onScreenControls(complain[position],complainKey[position])
    ];
  }

  incrementcounter(String key) async{
    try {
      var ref = fb.reference().child("MyComplains/$key/Views");
      await ref.once().then((data) async => {
        await ref.set(data.value + 1),
      });
    } catch (e) {
      print(e.message);
    }
  }
}
