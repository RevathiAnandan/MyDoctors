import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/complains.dart';

import 'NewComplains.dart';
class MyComplainList extends StatefulWidget {
  final String id;
  final String mobile;
  List<Complains> complain;
  MyComplainList(this.id, this.mobile,this.complain);
  @override
  _MyComplainListState createState() => _MyComplainListState();
}

class _MyComplainListState extends State<MyComplainList> {
  List dummyData =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          // Center(
          //   child: IconButton(
          //     icon: Icon(Icons.add,color: Colors.redAccent,),
          //     onPressed: (){
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>NewComplains(widget.id,widget.mobile),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
        title: Text("My Complains List (${widget.complain.length})",
            style: TextStyle(
                color: Colors.redAccent, fontFamily: "Lato", fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Card(
              child:
              widget.complain.length >0?
              ListView.builder(
                itemCount:widget.complain.length,
                itemBuilder:(context,index){
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        // title: Text(dummyData[index].userNumber),
                        title:Text("Complain Number: "+widget.complain[index].ComplainNumber,style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),),
                        subtitle: Text("About:" +widget.complain[index].About),
                        trailing: Container(
                          width: 200  ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                child: Text("Satisfied",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Lato",
                                        fontSize: 14)),
                                textColor: Colors.white,
                                onPressed: (){
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(25.0),
                                    side: BorderSide(
                                        color: Colors.redAccent)),
                                padding: EdgeInsets.all(10),
                                color: Colors.green,
                              ),
                              FlatButton(
                                child: Text("Resolved",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Lato",
                                        fontSize: 14)),
                                textColor: Colors.white,
                                onPressed: (){
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(25.0),
                                    side: BorderSide(
                                        color: Colors.redAccent)),
                                padding: EdgeInsets.all(10),
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    ],
                  );
                },
              )
            :Center(child: Text("No Data Found!!")),
          ),
        ),
      ),
    );
  }
}
