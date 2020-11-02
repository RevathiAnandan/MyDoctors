
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Precription.dart';
import 'package:myarogya_mydoctor/pages/patient/showPrecription.dart';

import 'createPrecription.dart';
class DoctorPrescriptionList extends StatefulWidget {
  String pmobile;
  String dmobile;
  String pname;
  String id;
  DoctorPrescriptionList(this.dmobile,this.pmobile,this.pname,this.id);

  @override
  _DoctorPrescriptionListState createState() => _DoctorPrescriptionListState();
}

class _DoctorPrescriptionListState extends State<DoctorPrescriptionList> {
  List dummyData= [];
  Prescription prescription1;
  var refreshValue;
  var isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrecriptionDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reports",style:TextStyle(color: Colors.redAccent) ,),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.redAccent),
            onPressed: ()async{
             Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body:isLoading
            ? Center(
            child: CircularProgressIndicator() ):
        (dummyData.isEmpty?Center(child: Text("No Reports Found!!")):new ListView.builder(
          itemCount:dummyData.length ,
          itemBuilder: (context, i) => new Column(
            children: <Widget>[
              new Divider(
                height: 10.0,
              ),
              new ListTile(
                  leading: new CircleAvatar(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey,
//                  backgroundImage: Image.asset('assets/images/grid.png'),
                  ),
                  title: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        dummyData[i].diagnosis != null ? dummyData[i].diagnosis : "New Data Found" ,
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),

                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>ShowPrecription(dummyData[i],widget.dmobile,widget.pmobile),
                        )
                    );
                  }
              )
            ],
          ),
        )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePrescription(widget.pmobile,widget.dmobile,widget.pname,widget.id)),
                );
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.redAccent,
      ),

    );
  }
  Future<Prescription> getPrecriptionDetails(){
    FirebaseDatabase fb = FirebaseDatabase.instance;
    try {
      var db = fb.reference().child("Prescription").child(widget.pmobile);
      db.once().then((DataSnapshot snapshot){
        print (snapshot.value);
        Map<dynamic, dynamic > values = snapshot.value;
        values.forEach((key,values) {

          prescription1 = Prescription.fromJson(values);
          setState(() {
            if(widget.pmobile == prescription1.patientMobile) {
              dummyData.add(prescription1);
            }
          
            isLoading = false;
          });
        });

        print (prescription1);

      });

    } catch (e) {
      print(e);
    }
  }

}
