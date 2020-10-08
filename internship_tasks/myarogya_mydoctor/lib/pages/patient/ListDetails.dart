import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/chat_model.dart';

import 'NavDrawer.dart';
class ListDetails extends StatefulWidget {
  String choice;
  ListDetails(this.choice);
  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: new Container(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0,bottom: 10.0),
                  height: MediaQuery.of(context).size.height * 20/100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: new Color(0xff1264D1),
                    borderRadius: BorderRadius.only(
                        bottomLeft:Radius.circular(15) ,
                        bottomRight: Radius.circular(15)
                    ),
                  ),
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/sidenav.png'),
                          Image.asset('assets/images/user_profile.png')
                        ],
                      ),
                      Container(
//                        padding: EdgeInsets.all(20),
                        child:Text(widget.choice,style: new TextStyle(color:Colors.white,fontSize:32,fontWeight: FontWeight.bold,fontFamily: "Lato")),
                      )
                    ],
                  ),
                ),

              ],

            ),
//            Column(
//              children: [
//                Container(
//                  child:  ListView.builder(
//                    itemCount: dummyData.length,
//                    itemBuilder: (context, i) => new Column(
//                      children: <Widget>[
//                        new Divider(
//                          height: 10.0,
//                        ),
//                        new ListTile(
//                          leading: new CircleAvatar(
//                            foregroundColor: Theme.of(context).primaryColor,
//                            backgroundColor: Colors.grey,
//                            backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
//                          ),
//                          title: new Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              new Text(
//                                dummyData[i].name,
//                                style: new TextStyle(fontWeight: FontWeight.bold),
//                              ),
//                              new Text(
//                                dummyData[i].time,
//                                style: new TextStyle(color: Colors.grey, fontSize: 14.0),
//                              ),
//                            ],
//                          ),
//                          subtitle: new Container(
//                            padding: const EdgeInsets.only(top: 5.0),
//                            child: new Text(
//                              dummyData[i].message,
//                              style: new TextStyle(color: Colors.grey, fontSize: 15.0),
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                )
//              ],
//            ),

          ],
        ),
      ),
    );
  }
}
