import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_1/medicinetests.dart';
import 'package:task_1/my_flutter_app_icons.dart';
import 'package:task_1/page2.dart';
import 'datetime.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> medicine = [];

  addmedicine() {
    medicine.add(new MedicineTests());
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

  String _chosenValue2 = 'Before Food';
  final myController = TextEditingController();
  DateTime date1;
  DateTime date2;
  DateTime date3;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 15, top: 10),
                width: width,
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
                height: 20,
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
                        height: 100,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      Positioned(
                        left: 280,
                        top: 50,
                        child: MaterialButton(
                          elevation: 8,
                          onPressed: (){},
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 35,
                          ),
                          shape: CircleBorder(),
                          color: Colors.blue[600],
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 370,
                height: 250,
                child: Flexible(
                  child: ListView.builder(
                    itemCount: medicine.length,
                      itemBuilder: (_, index) => medicine[index]),
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
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Prescribed on",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 3),
                      // height: 90,
                      width: 180,
                      // decoration: BoxDecoration(
                      //     color: Colors.grey[200],
                      //     borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: DateTimePickerFormField(
                        inputType: InputType.both,
                        format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                        editable: false,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            labelText: 'Date and Time',
                            hasFloatingPlaceholder: false),
                        onChanged: (dt) {
                          setState(() => date1 = dt);
                          print('Selected date: $date1');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
