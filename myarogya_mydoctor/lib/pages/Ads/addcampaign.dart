import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Ads.dart';
import 'package:myarogya_mydoctor/pages/Ads/showvideo.dart';
import 'package:myarogya_mydoctor/pages/widget/home/home_video_renderer.dart';

import 'addAds.dart';

class AdsUserProfile extends StatefulWidget {

  final String id;
  final String mobile;

  AdsUserProfile(this.id, this.mobile);

  @override
  _AdsUserProfileState createState() => _AdsUserProfileState();
}

class _AdsUserProfileState extends State<AdsUserProfile> {

  FirebaseDatabase fb = FirebaseDatabase.instance;
  List<MyAds> myads = [];
  int _current = 0;
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
        automaticallyImplyLeading: false,
        title: Text('My Ads Profile',style: TextStyle(
          color: Colors.redAccent,
          fontSize: 18,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
        ),),
        actions: [
          Center(
            child: Text(
              "Add",style: TextStyle(
              color: Colors.redAccent,
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          IconButton(
            color: Colors.redAccent,
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>Addads(widget.id,widget.mobile),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "List of my Ads",style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text(
                  "10",style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wallet Balance",style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
                ),
                Row(
                  children: [
                    Text(
                      "Rs.100",style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    MaterialButton(
                      height: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(25.0),
                          side: BorderSide(
                              color: Colors.redAccent)),
                      color: Colors.redAccent,
                      child: Text("Recharge",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),),
                      onPressed: () {  },

                    )
                  ],
                ),
              ],
            ),
            Container(
              height: 500,
              child: isLoading?Center(child: CircularProgressIndicator(),):
              ListView.builder(
                      itemCount: myads.length,
                    itemBuilder: (context,index){
                      final List<Widget> imageSliders =
                          [Container(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  (myads[index].image!=null)?Image.network(myads[index].image, fit: BoxFit.cover, width: 1000.0):Container(),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                      child: Text(
                                        '${myads[index].slogan} ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                            Container(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  (myads[index].video!=null)?AppVideoPlayer(myads[index].video):Container(),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                      child: Text(
                                        '${myads[index].slogan} ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      )];
                        return Row(
                          children: [
                            Container(
                              height:170,
                              width: 300,
                              child: Card(
                                child:
                                Stack(
                                  children: [
                                    CarouselSlider(
                                      items: imageSliders,
                                      options: CarouselOptions(
                                        enableInfiniteScroll: false,
                                          // enlargeCenterPage: true,
                                          aspectRatio: 2,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _current = index;
                                            });
                                          }
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: myads[index].media.map((url) {
                                    //     int number = myads[index].media.indexOf(url);
                                    //     return Container(
                                    //       width: 8.0,
                                    //       height: 8.0,
                                    //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                    //       decoration: BoxDecoration(
                                    //         shape: BoxShape.circle,
                                    //         color: _current == number
                                    //             ? Color.fromRGBO(0, 0, 0, 0.9)
                                    //             : Color.fromRGBO(0, 0, 0, 0.4),
                                    //       ),
                                    //     );
                                    //   }).toList(),
                                    // ),
                                  ],
                                )
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Card(
                                    // width:
                                  ),
                                ),
                                Container(
                                  child:MaterialButton(

                                  )
                                ),
                              ],
                            ),
                          ],
                        );
                    },
                  ),
            ),
          ],
        ),
      ),
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
          print(widget.mobile);

          if(widget.mobile==refreshToken.mobile){
            myads.add(refreshToken);
          }
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
