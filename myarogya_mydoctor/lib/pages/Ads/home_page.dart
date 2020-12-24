import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/dropdownlists.dart';
import 'package:myarogya_mydoctor/model/Ads.dart';
import 'package:myarogya_mydoctor/pages/Ads/addAds.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/appBarControls.dart';
import 'package:myarogya_mydoctor/pages/widget/home/controls/onscreen_controls.dart';
import 'package:myarogya_mydoctor/pages/widget/home/home_video_renderer.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';

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
  List<MyAds> nextads = [];
  List keys = [];
  bool isLoading = true;
  int nxtadindex = 0;
  PageController _pagePosition = PageController();
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
      body: isLoading?Column(
        children: [
          LinearProgressIndicator(),
          Text("Your ads is on the way!!")
        ],
      ):Row(
        children: [
          Flexible(
            flex:5,
            child: PageView.builder(
              onPageChanged: (index){
                setState(() {
                  nxtadindex = index+1;
                });
              },
              scrollDirection: Axis.vertical,
              controller: _pagePosition,
              itemBuilder: (context, position) {
                print("Harun"+_pagePosition.toString());
                return Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: stackwidgets(position),
                  ),
                );
              },
              itemCount: myads.length),
          ),
          Flexible(
           flex: 2,
           child: Column(
             children: [
               SizedBox(height: 10,),
               Flexible(
                 flex: 0,
                 child: Center(child: Text("Product Category"),),
               ),
               new Divider(
                 height: 10.0,
                 color: Colors.redAccent,
               ),
               Flexible(
                 child: ListView.builder(
                   itemCount: Dropdownlists().adscategories.length,
                   itemBuilder: (context,index){
                     return Column(
                       children: [
                         MaterialButton(
                           child: Text(Dropdownlists().adscategories[index],style: TextStyle(
                             color: Colors.redAccent,
                             fontSize: 15.0,
                             fontFamily: 'Lato',
                             fontWeight: FontWeight.bold,
                           ),),
                           onPressed: (){
                             filterAds(Dropdownlists().adscategories[index]);
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
               // Expanded(
               //   child: ListView.builder(
               //     itemCount: 3,
               //     itemBuilder: (_,index){
               //       return Column(
               //         children: [
               //           Container(
               //             height:75,
               //             decoration: BoxDecoration(
               //               // color: (add) ? Colors.green : Colors.red,
               //               borderRadius: BorderRadius.circular(20),
               //             ),
               //             // child: myads[index+nxtadindex].video=="" ? Image.network(myads[index+nxtadindex].image,fit: BoxFit.fill,):AppVideoPlayer(myads[index+nxtadindex].video),
               //             child: myads[nxtadindex].video=="" ? Image.network(myads[nxtadindex].image,fit: BoxFit.fill,):AppVideoPlayer(myads[nxtadindex].video),
               //           ),
               //           SizedBox(height: 10,),
               //         ],
               //       );
               //     },
               //   ),
               // ),
             ],
           ),
          ),
        ]
    ),
    );
  }


  List<Widget> stackwidgets(position)  {
    print(position.toString());
    incrementcounter(keys[position]);
    // nextthreeads(position);
    return [
      if(myads[position].video=="")
        Image.network(myads[position].image)
      else
        AppVideoPlayer(myads[position].video),
      onScreenControlsA(myads[position],myads,position)
    ];
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
          keys.add(key);
          print(myads.toString());
          setState(() {
            isLoading =false;
          });
        });
        print(isLoading.toString());
      }
    });
  }

  nextthreeads(int position){
    print(position.toString());
    nextads.add(myads[position+1]);
    print("Harun"+nextads.toString());
  }
  incrementcounter(String key) async{
    try {
      var ref = fb.reference().child("MyAds/$key/Views");
      await ref.once().then((data) async => {
        await ref.set(data.value + 1),
      });
    } catch (e) {
      print(e.message);
    }
  }

   filterAds(String catogory) async {
    nextads.clear();
     setState(() {
       isLoading =true;
     });

    print("Enter filter ads");
     await fb.reference().child("MyAds").once().then((DataSnapshot snapshot) {
       print(snapshot);
       if (snapshot.value != null) {
         Map<dynamic, dynamic> values = snapshot.value;
         values.forEach((key, values) {
           var refreshToken = MyAds.fromJson(values);
           print(refreshToken.mobile);
           if (refreshToken.productCatogory == catogory) {
             myads.add(refreshToken);
           }
           setState(() {
             isLoading =false;
           });
         });
         print(isLoading.toString());
       }
     });
  }
}
