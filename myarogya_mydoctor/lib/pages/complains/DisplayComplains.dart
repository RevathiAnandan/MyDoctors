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
  List<Complains> filterdata = [];
  List<String> complainKey = [];
  Widget appBarTitle = new Text("My Complains",
      style: TextStyle(
          color: Colors.redAccent,
          fontFamily: "Lato",
          fontSize: 20));
  Icon actionIcon = new Icon(Icons.search, color: Colors.redAccent,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  bool isLoading = true;
  bool _IsSearching;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComplains();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      // AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   actions: [
      //     IconButton(icon: Icon(Icons.search,color: Colors.redAccent),
      //       onPressed: (){
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(
      //         //     builder: (context) =>Addads(widget.id,widget.mobile),
      //         //   ),
      //         // );
      //       },),
      //     IconButton(icon: Icon(Icons.add,color: Colors.redAccent),
      //       onPressed: (){
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) =>NewComplains(widget.id,widget.mobile),
      //           ),
      //         );
      //       },),
      //     IconButton(icon: Icon(Icons.list,color: Colors.redAccent),
      //       onPressed: (){
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) =>MyComplainList(widget.id,widget.mobile,complain),
      //           ),
      //         );
      //       },),
      //     IconButton(icon: Icon(Icons.announcement,color: Colors.redAccent),
      //       onPressed: (){
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) =>ComplainResolution(widget.id,widget.mobile),
      //           ),
      //         );
      //       },),
      //   ],
      //   title: appBarTitle,
      // ),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent
                    ),
                    child: Center(child: Text("Issue Category",style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),),),
                  ),
                ),
                // new Divider(
                //   height: 10.0,
                //   color: Colors.redAccent,
                // ),
                Flexible(
                  flex: 10,
                  child: ListView.builder(
                    itemCount: Dropdownlists().categories.length,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          Container(
                            height: 30,
                            child: MaterialButton(
                              child: Text(Dropdownlists().categories[index],style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 13.0,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                              ),),
                              onPressed: (){
                                  filtercomplains(Dropdownlists().categories[index]);
                              },
                            ),
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
          filterdata.add(refreshToken);
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
  Widget buildBar(BuildContext context) {
    return new AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
        // centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.redAccent,);
                this.appBarTitle = new TextField(
                  onChanged: (text){
                    setState(() {
                      complain = filterdata
                          .where((u) => (u.ComplainNumber
                          .toLowerCase()
                          .contains(text.toLowerCase())||u.About
                          .toLowerCase()
                          .contains(text.toLowerCase()) ||
                          u.Category
                              .toLowerCase().contains(text.toLowerCase())||u.location
                          .toLowerCase().contains(text.toLowerCase())))
                          .toList();
                    });
                  },
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.redAccent,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.redAccent),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
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
        ]
    );
  }
  void _handleSearchStart() {
    setState(() {
       _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.redAccent,);
      this.appBarTitle =
      new Text("My Complains",
          style: TextStyle(
              color: Colors.redAccent,
              fontFamily: "Lato",
              fontSize: 20));
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}
