import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class ComplainResolution extends StatefulWidget {
  final String id;
  final String mobile;

  ComplainResolution(this.id, this.mobile);
  @override
  _ComplainResolutionState createState() => _ComplainResolutionState();
}

class _ComplainResolutionState extends State<ComplainResolution> {
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        title: Text("My Complain Resolution",
            style: TextStyle(
                color: Colors.redAccent, fontFamily: "Lato", fontSize: 20)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Card(
          child:
          // widget.complain.length >0?
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
                        child: Text("Reply",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Lato",
                                fontSize: 14)),
                        textColor: Colors.white,
                        onPressed: (){
                          _openPopup(context);
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
    );
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Reply",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              controller: name,
              maxLines: 8,
            ),
            // TextField(
            //   inputFormatters: [
            //     LengthLimitingTextInputFormatter(10),
            //   ],
            //   decoration: InputDecoration(
            //     icon: Icon(Icons.phone_android),
            //     labelText: 'Mobile Number',
            //   ),
            //   controller: phone,
            //   keyboardType: TextInputType.number,
            // ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: (){

            },
            child: Text(
              "Send",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

}
