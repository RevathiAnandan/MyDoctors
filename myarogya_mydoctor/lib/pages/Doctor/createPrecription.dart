
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import '../labtests.dart';
import 'package:date_format/date_format.dart';
import '../my_flutter_app_icons.dart';
import 'addmedicine.dart';
class CreatePrescription extends StatefulWidget {
  String pmobile,dmobile,pname,id;

  CreatePrescription(this.pmobile,this.dmobile,this.pname,this.id);
  @override
  _CreatePrescriptionState createState() => _CreatePrescriptionState();
}

class _CreatePrescriptionState extends State<CreatePrescription> {
  TextEditingController diaController = TextEditingController();
  TextEditingController mController = TextEditingController();
  TextEditingController d1Controller = TextEditingController();
  TextEditingController d2Controller = TextEditingController();
  TextEditingController d3Controller = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController bpController1 = TextEditingController();
  TextEditingController pulseController = TextEditingController();
  TextEditingController labController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  List<Widget> medicine = [];
  List<Widget> labtests = [];

  List medicineDetails =[];
  List precriptionDetails =[];
  List labDetails =[];
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  addmedicine() {
    medicine.add(new AddMedicine(mController.text,d1Controller.text,d2Controller.text,d3Controller.text,daysController.text,_chosenValue2));
    medicineDetails.add(
        {
          "medicine":mController.text,
          "dosage":"${d1Controller.text}-${d2Controller.text}-${d3Controller.text}",
          "days":daysController.text,
          "duration":_chosenValue2,
        }
    );
    clearText();
    setState(() {});
  }

  clearText(){
    mController.clear();
    d1Controller.clear();
    d2Controller.clear();
    d3Controller.clear();
    daysController.clear();
  }
  addLabtests() {
    labtests.add(Labtests(labController.text));
    labDetails.add(
        {
          "test":labController.text
        }
    );
    labController.clear();
    setState(() {});
  }

  int days = 1;
  void daysplus() {
    setState(() {
      days++;
    });
  }

  void daysminus() {
    setState(() {
      if (days != 0) {
        days--;
      } else {
        days = 0;
      }
    });
  }
  String _chosenValue2 = 'Before Meal';

  DateTime date1;
  DateTime date2;
  DateTime date3;
  DateTime date4;
  String date5;
  DateTime date6;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              child:Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0,bottom: 0.0),
                      height: MediaQuery.of(context).size.height * 15/100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                            bottomLeft:Radius.circular(15) ,
                            bottomRight: Radius.circular(15)
                        ),
                      ),
                      child:Center(
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Add Prescription', style: TextStyle(color:Colors.white, fontSize: 26, fontWeight: FontWeight.w500,fontFamily: "Lato"))
                          ],
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Diagnosis',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Container(
                            height: 80,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child:  TextField(
                              controller: diaController,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                              maxLength: 100,
                              keyboardType: TextInputType.text,
                              // textAlign: TextAlign.center,,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(16.0),
                                  border: InputBorder.none,
                                  counterText: ""),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      )),
                  Column(
                      children:[
                        Expanded(
                          flex: 0,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: medicine.length,
                              itemBuilder: (_, index) => medicine[index]),
                        ),
                      ]
                  ),
                  Container(
                    width: 400,
                    height: 200,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Medicine',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6), fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 350,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                                child:  TextField(
                                  controller: mController,
                                  onEditingComplete: () =>
                                      FocusScope.of(context).nextFocus(),
                                  keyboardType: TextInputType.text,

                                  // textAlign: TextAlign.center,,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(16.0),
                                      border: InputBorder.none,
                                      counterText: ""),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('Dosage',style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 18,
                                  ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(14)),
                                                    child: TextField(
                                                      controller: d1Controller,
                                                      onEditingComplete: () =>
                                                          FocusScope.of(context).nextFocus(),
                                                      maxLength: 1,
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.digitsOnly
                                                      ],
                                                      // textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.all(16.0),
                                                          border: InputBorder.none,
                                                          counterText: ""),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(14)),
                                                    child: TextField(
                                                      controller: d2Controller,
                                                      onEditingComplete: () =>
                                                          FocusScope.of(context).nextFocus(),
                                                      maxLength: 1,
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.digitsOnly
                                                      ],
                                                      // textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.all(16.0),
                                                          border: InputBorder.none,
                                                          counterText: ""),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(14)),
                                                    child: TextField(
                                                      controller: d3Controller,
                                                      onEditingComplete: () =>
                                                          FocusScope.of(context).nextFocus(),
                                                      maxLength: 1,
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.digitsOnly
                                                      ],
                                                      // textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.all(16.0),
                                                          border: InputBorder.none,
                                                          counterText: ""),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Days',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5),
                                      height: 50,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: daysController,
                                          onEditingComplete: () =>
                                              FocusScope.of(context).nextFocus(),
                                          maxLength: 2,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          // textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(16.0),
                                              border: InputBorder.none,
                                              counterText: ""),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'To Be Taken',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6), fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 110,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 42,
                                      value: _chosenValue2,
                                      underline: SizedBox(),
                                      items: <String>['Before Meal', 'After Meal']
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValue2 = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addmedicine,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18.0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 160,
                                    child: Text(
                                      'BP',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 18),
                                    ),
                                  ),

//                                Container(
//                                  height: 50,
//                                  width: 170,
//                                  decoration: BoxDecoration(
//                                      color: Colors.grey[200],
//                                      borderRadius:
//                                      BorderRadius.all(Radius.circular(10))),
//                                  child:  TextField(
//                                    controller: bpController,
//                                    onEditingComplete: () =>
//                                        FocusScope.of(context).nextFocus(),
//                                    maxLength: 100,
//                                    keyboardType: TextInputType.number,
//
//                                    // textAlign: TextAlign.center,,
//                                    decoration: InputDecoration(
//                                        contentPadding: EdgeInsets.all(16.0),
//                                        border: InputBorder.none,
//                                        counterText: ""),
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
//                                        fontSize: 15,
//                                        color: Colors.black),
//                                  ),
//                                ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 55,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(14)),
                                                    child: TextField(
                                                      controller:  bpController,
                                                      onEditingComplete: () =>
                                                          FocusScope.of(context).nextFocus(),
                                                      maxLength: 3,
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter.digitsOnly
                                                      ],
                                                      // textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.all(16.0),
                                                          border: InputBorder.none,
                                                          counterText: ""),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(14)),
                                                    child: Center(
                                                      child: TextField(
                                                        controller:  bpController1,
                                                        onEditingComplete: () =>
                                                            FocusScope.of(context).nextFocus(),
                                                        maxLength: 3,
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter.digitsOnly
                                                        ],
                                                        // textAlign: TextAlign.center,
                                                        decoration: InputDecoration(
                                                            contentPadding: EdgeInsets.all(16.0),
                                                            border: InputBorder.none,
                                                            counterText: ""),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15,
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 160,
                                    child: Text(
                                      'Weight',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: EdgeInsets.only(left: 5),
                                            height: 50,
                                            width: 170,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: TextField(
                                                controller: weightController,
                                                onEditingComplete: () =>
                                                    FocusScope.of(context)
                                                        .nextFocus(),
                                                maxLength: 3,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                // textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets.all(16.0),
                                                    border: InputBorder.none,
                                                    counterText: ""),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 160,
                                    child: Text(
                                      'Next Visit',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 55,
                                    width: 170,
                                    child: DateTimeField(
                                      format: DateFormat("dd-MM-yyyy"),
                                      //editable: false,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                          border: OutlineInputBorder(),
                                          labelText: 'Next Visit',
                                          floatingLabelBehavior: FloatingLabelBehavior.never
                                      ),
                                      onShowPicker: (context,dt){
                                        return showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1990),
                                          lastDate: DateTime(2050),
                                        );
                                      },
                                      onChanged: (dt) {
                                        setState(() {
                                          date5 = formatDate( dt , [dd, ' ', MM, ' ', yyyy]);
                                          ApiService().addpres();
                                        });
                                        //setState(() => date5 = formatDate( dt , [dd, ' ', MM, ' ', yyyy]));
                                        print('Selected date: $date5');
                                        print(date5);
                                        print(ApiService().no);
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 160,
                                          child: Text(
                                            'Pulse',
                                            style: TextStyle(
                                                color: Colors.black.withOpacity(0.6),
                                                fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 5),
                                                  height: 50,
                                                  width: 170,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10))),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: TextField(
                                                      controller: pulseController,
                                                      onEditingComplete: () =>
                                                          FocusScope.of(context)
                                                              .nextFocus(),
                                                      maxLength: 3,
                                                      keyboardType:
                                                      TextInputType.number,

                                                      // textAlign: TextAlign.center,
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                          EdgeInsets.all(16.0),
                                                          border: InputBorder.none,
                                                          counterText: ""),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 10),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 0,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: labtests.length,
                              itemBuilder: (_, index) => labtests[index]),

                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:18.0,right: 18.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Lab Tests',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            // padding: EdgeInsets.all(10),
                            child: Stack(
                              children: [
                                Container(
                                  height: 70,
                                  width: 380,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child:  TextField(
                                    controller: labController,
                                    onEditingComplete: () =>
                                        FocusScope.of(context).nextFocus(),
                                    keyboardType: TextInputType.text,

                                    // textAlign: TextAlign.center,,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(16.0),
                                        border: InputBorder.none,
                                        counterText: ""),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                                // Positioned(
                                //   left:300,
                                //   top: 23,
                                //   child: MaterialButton(
                                //     elevation: 8,
                                //     onPressed: () {
                                //       addLabtests();
                                //     },
                                //     child: Icon(
                                //       Icons.add,
                                //       color: Colors.white,
                                //       size: 25,
                                //     ),
                                //     shape: CircleBorder(
                                //     ),
                                //     color: Colors.redAccent,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18.0),
                    child: FlatButton(
                      child: Text("PRESCRIBE",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14)),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.redAccent)
                      ),
                      padding: EdgeInsets.all(16),
                      onPressed: (){
                        print("values"+medicineDetails.toString());
                        print("test"+labDetails.toString());
                        ApiService().addPrecription(widget.pmobile,widget.dmobile,widget.pname,medicineDetails,labController.text,diaController.text,bpController.text,weightController.text,pulseController.text,date5, formatDate( DateTime.now() , [dd, ' ', MM, ' ', yyyy,'/', HH , ':', nn]),bpController1.text);
                        AuthService().toast("Prescription Created Successfully!!");
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>DashBoardScreen(widget.dmobile,"MY PATIENT",widget.id),
                          ),
                        );
                      },
                      color: Colors.redAccent,
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
