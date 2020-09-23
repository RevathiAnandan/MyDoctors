import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_1/labtests.dart';
import 'package:task_1/my_flutter_app_icons.dart';
import 'datetime.dart';
import 'main.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<Widget> labtests = [];

  addLabtests() {
    labtests.add(Labtests());
    setState(() {});
  }

  DateTime date4;

  DateTime date5;

  DateTime date6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 15, top: 10),
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    color: Colors.blue[600]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            MyFlutterApp.bx_menu_alt_left,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/circleavatar.jpg'),
                            radius: 32,
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Prescription',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      'Mr. Rajan Gupta, M, 38',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 200,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Container(
                                width: 160,
                                child: Text(
                                  'Date',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                //padding: EdgeInsets.only(left: 5),
                                height: 50,
                                width: 170,
                                // decoration: BoxDecoration(
                                //     color: Colors.grey[200],
                                //     borderRadius:
                                //     BorderRadius.all(Radius.circular(10))),
                                child: DateTimePickerFormField(
                                  inputType: InputType.date,
                                  format: DateFormat("yyyy-MM-dd"),
                                  initialDate: DateTime(2019, 1, 1),
                                  editable: false,
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      border: OutlineInputBorder(),
                                      labelText: 'Date',
                                      hasFloatingPlaceholder: false),
                                  onChanged: (dt) {
                                    setState(() => date5 = dt);
                                    print('Selected date: $date5');
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
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
                                                  //controller: myController,
                                                  onEditingComplete: () =>
                                                      FocusScope.of(context)
                                                          .nextFocus(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
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
                                                      fontSize: 25,
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
                    SizedBox(
                      width: 25,
                    ),
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
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 50,
                                width: 170,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 110,
                                      top: 10,
                                      child: MaterialButton(
                                        height: 20,
                                        elevation: 8,
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        shape: CircleBorder(),
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                            //controller: myController,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
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
                                                fontSize: 25,
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
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 10),
                height: 290,
                width: 500,
                child: Column(
                  children: [
                    Container(
                      width: 370,
                      height: 130,
                      child: Flexible(
                        child: ListView.builder(
                          itemCount: labtests.length,
                            itemBuilder: (_, index) => labtests[index]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Add Lab Tests',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6), fontSize: 18),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 40,
                            child: MaterialButton(
                              elevation: 8,
                              onPressed: addLabtests,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 35,
                              ),
                              shape: CircleBorder(),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 160,
                        child: Text(
                          'Next Visit',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6), fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        //padding: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 170,
                        // decoration: BoxDecoration(
                        //     color: Colors.grey[200],
                        //     borderRadius:
                        //     BorderRadius.all(Radius.circular(10))),
                        child: DateTimePickerFormField(
                          inputType: InputType.date,
                          format: DateFormat("yyyy-MM-dd"),
                          initialDate: DateTime(2019, 1, 1),
                          editable: false,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              border: OutlineInputBorder(),
                              labelText: 'Date',
                              hasFloatingPlaceholder: false),
                          onChanged: (dt) {
                            setState(() => date5 = dt);
                            print('Selected date: $date5');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ButtonTheme(
                minWidth: 200,
                height: 50,
                child: RaisedButton(
                  elevation: 7,
                  color: Colors.blue[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Page2()),
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
