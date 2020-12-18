import 'package:flutter/material.dart';

import 'NewComplains.dart';
class MyComplainList extends StatefulWidget {
  final String id;
  final String mobile;
  MyComplainList(this.id, this.mobile);
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
          Center(
            child: IconButton(
              icon: Icon(Icons.add,color: Colors.redAccent,),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>NewComplains(widget.id,widget.mobile),
                  ),
                );
              },
            ),
          ),
        ],
        title: Text("My ComplainsList",
            style: TextStyle(
                color: Colors.redAccent, fontFamily: "Lato", fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 200,
          child: Card(
              child:
              // dummyData.length >0?
              ListView.builder(
                itemCount:2,
                itemBuilder:(context,index){
                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    // title: Text(dummyData[index].userNumber),
                    title:Text("Complain Number:"),
                    trailing: Container(
                      width: 200  ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            child: Text("Not Satisfied",
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
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            // :Center(child: Text("No Data Found!!")),
          ),
        ),
      ),
    );
  }
}
