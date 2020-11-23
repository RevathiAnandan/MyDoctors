import 'package:flutter/material.dart';
class MyBooking extends StatefulWidget {
  String id;
  String mobile;
  MyBooking(this.id,this.mobile);
  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hospital"),
    );
//    return Scaffold(
//      body:
//      NestedScrollView(
//        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//          return <Widget>[
//            SliverAppBar(
//              backgroundColor: Colors.white,
//              expandedHeight: 250.0,
//              floating: false,
//              pinned: true,
//              leading: Container(),
//              flexibleSpace: FlexibleSpaceBar(
//                centerTitle: true,
//                title: Align(
//                  alignment: Alignment.bottomLeft,
//                  child: Text(
//                    "    MyBooking",
//                    style: TextStyle(
//                      color: Colors.redAccent,
//                      fontSize: 25.0,
//                      fontFamily: 'Lato',
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                ),
//                background: Image.network(
//                  "https://www.connect5000.com/wp-content/uploads/2016/07/blog-pic-117-1.jpeg",
//                  fit: BoxFit.cover,
//                ),
//              ),
//              actions: [
//                IconButton(
//                  icon: Icon(Icons.search, color: Colors.redAccent,size: 30,),
//                  onPressed: () {
//                    showSearch(context: context, delegate: DataSearch());
//                  },
//                ),
//                IconButton(
//                  icon: Icon(Icons.add, color: Colors.redAccent,size: 35,),
//                  onPressed: () {
////                    _openPopup(context);
//                  },
//                ),
////                PopupMenuButton<String>(
////                  onSelected: choiceAction,
////                  itemBuilder: (BuildContext context){
////                    return ConstantsD.choices.map((String choice){
////                      return PopupMenuItem<String>(
////                        value: choice,
////                        child: Text(choice),
////                      );
////                    }).toList();
////                  },
////                )
//              ],
//            ),
//            new SliverPadding(
//              padding: new EdgeInsets.all(1.0),
//              sliver: new SliverList(
//                  delegate: SliverChildListDelegate([
//                    Row(
//                      mainAxisSize: MainAxisSize.max,
//                      children: [
//                        Container(
//                          padding: EdgeInsets.only(top: 16),
//                          child: Row(
//                            mainAxisSize: MainAxisSize.max,
//                            children: <Widget>[
//                              Column(
//                                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                children: <Widget>[
//                                  Container(
//                                    width: 130,
//                                    height: 40,
//                                    child: Card(
//                                      color: new Color(0xffFFFFFF),
//                                      elevation: 6,
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius:
//                                          BorderRadius.circular(20)),
//                                      child: Center(
//                                          child: GestureDetector(
//                                            // onTap: () => Navigator.pop(context),
//                                              child: Text("My Waiting",
//                                                  style: new TextStyle(
//                                                      color: Colors.redAccent,
//                                                      fontSize: 14,
//                                                      fontWeight: FontWeight.bold,
//                                                      fontFamily: "Lato")))),
//                                    ),
//                                  ),
//                                  Text((dummyData.length == 0?"0":(dummyData.length).toString()),
//                                      style: new TextStyle(
//                                          color: Colors.black,
//                                          fontSize: 16,
//                                          fontWeight: FontWeight.bold,
//                                          fontFamily: "Lato")),
//                                ],
//                              ),
//                            ],
//                          ),
//                        ),
//                        Container(
//                          padding: EdgeInsets.only(top: 16),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              Column(
//                                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                children: <Widget>[
//                                  Container(
//                                    width: 130,
//                                    height: 40,
//                                    child: Card(
//                                      color: new Color(0xffFFFFFF),
//                                      elevation: 6,
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius:
//                                          BorderRadius.circular(20)),
//                                      child: Center(
//                                          child: GestureDetector(
//                                              onTap: () => Navigator.push(
//                                                context,
//                                                MaterialPageRoute(
//                                                    builder: (context) =>
//                                                        DashBoardScreen(
//                                                            widget.mobile,
//                                                            "MY PATIENT",widget.id)),
//                                              ),
//                                              child: Text("My Patient",
//                                                  style: new TextStyle(
//                                                      color: Colors.redAccent,
//                                                      fontSize: 14,
//                                                      fontWeight: FontWeight.bold,
//                                                      fontFamily: "Lato")))),
//                                    ),
//                                  ),
//                                  SizedBox(height: 5.0),
//                                  Text(refresh.length.toString(),
//                                      style: new TextStyle(
//                                          color: Colors.black,
//                                          fontSize: 16,
//                                          fontWeight: FontWeight.bold,
//                                          fontFamily: "Lato")),
//                                ],
//                              ),
//                            ],
//                          ),
//                        ),
//                        Container(
//                          padding: EdgeInsets.only(top: 16),
//                          child: Row(
////                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[]),
//                        ),
//                        Container(
//                          padding: EdgeInsets.only(top: 16),
//                          child: Row(
////                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              Column(
////                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                children: <Widget>[
//                                  Container(
//                                    width: 130,
//                                    height: 40,
//                                    child: Card(
//                                      color: new Color(0xffFFFFFF),
//                                      elevation: 6,
//                                      shape: RoundedRectangleBorder(
//                                          borderRadius:
//                                          BorderRadius.circular(20)),
//                                      child: Center(
//                                          child: GestureDetector(
//                                              onTap: () => Navigator.pop(context),
//                                              child: Text("Next Visit",
//                                                  style: new TextStyle(
//                                                      color: Colors.redAccent,
//                                                      fontSize: 14,
//                                                      fontWeight: FontWeight.bold,
//                                                      fontFamily: "Lato")))),
//                                    ),
//                                  ),
//                                  SizedBox(height: 5.0),
//                                  Text(ApiService().addpres().toString()== null ?"0":ApiService().addpres().toString(),
//                                      style: new TextStyle(
//                                          color: Colors.black,
//                                          fontSize: 16,
//                                          fontWeight: FontWeight.bold,
//                                          fontFamily: "Lato")),
//                                ],
//                              ),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  ])),
//            ),
//          ];
//        },
//        body: Card(
////          child: ListView.builder(
////            shrinkWrap: true,
////            itemCount:
////            dummyData.length < range ? dummyData.length : null,
////            itemBuilder: (context, i) => new Column(
////              children: <Widget>[
////                new Divider(
////                  height: 10.0,
////                ),
////                ListTile(
////                  leading: Text((i + 1).toString(),
////                      style: new TextStyle(
////                          fontWeight: FontWeight.bold,
////                          fontFamily: "Lato",
////                          color: Colors.redAccent,
////                          fontSize: 25)),
////                  title: Text(dummyData[i].doctorName),
////                  subtitle: Text(dummyData[i].patientMobile),
////                  trailing: (dummyData[i].status != "Waiting!")
////                      ? FlatButton(
////                    child: Text(timesplit(start1),
////                        style: TextStyle(
////                            color: Colors.white,
////                            fontFamily: "Lato",
////                            fontSize: 14)),
////                    textColor: Colors.white,
////                    shape: RoundedRectangleBorder(
////                        borderRadius:
////                        BorderRadius.circular(25.0),
////                        side: BorderSide(
////                            color: Colors.redAccent)),
////                    padding: EdgeInsets.all(10),
////                    color: Colors.redAccent,
////                    onPressed: () {
//////                      AuthService().toast("Next Appointment:"+timesplit(start1));
////                    },
////                  )
////                      : FlatButton(
////                    child: Text("Confirm",
////                        style: TextStyle(
////                            color: Colors.white,
////                            fontFamily: "Lato",
////                            fontSize: 14)),
////                    textColor: Colors.white,
////                    shape: RoundedRectangleBorder(
////                        borderRadius:
////                        BorderRadius.circular(25.0),
////                        side: BorderSide(
////                            color: Colors.redAccent)),
////                    padding: EdgeInsets.all(10),
////                    onPressed: () async {
////                      if (i == 0) {
////                      } else {
////                        setState(() {
//////                          start1 = start1.add(
//////                              new Duration(minutes: interval1));
//////                          h=2;
////                        });
////                      }
//////                      ApiService().appointment(
//////                          dummyData[i].patientMobile,
//////                          widget.mobile,
//////                          dummyData[i].doctorName,
//////                          "View",
//////                          i + 1,
//////                          start1.toString(),
//////                          keys1[i],h.toString());
//////                      ApiService().trigger=false;
////                    },
////                    color: Colors.redAccent,
////                  ),
////
////                ),
////                new Divider(
////                  height: 10.0,
////                ),
////              ],
////            ),
////          ),
//        ),
//        // ),
//      ),
//    );
  }
}
