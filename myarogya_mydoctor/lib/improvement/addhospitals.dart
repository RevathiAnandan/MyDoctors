import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarogya_mydoctor/improvement/AddDiagnosisCharged.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';

import 'addSpecialBed.dart';

class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  TextEditingController _nameController;
  static List<String> doctorsList = [null];
  static List<String> nursesList = [null];
  static List<String> staffsList = [null];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  List<Widget> specialBeds = [];
  List<Widget> diagnosisCharge = [];
  List<Widget> healthCharges = [];
  List<Widget> TPAInsurance = [];
  List Beds = [];
  List freebeds = [];
  List conbeds = [];
  List diagnosis = [];
  List health = [];
  List TPA = [];
  List topics = [
    "Hospital Details",
    "Important Numbers",
    "Room Tariff",
    "Diagnosis Charges",
    "Health Checkup Packages",
    "Speciality",
    "Facility",
    "Staff Details",
    "Insurance"
  ];
  int pageindex = 0;
  String _chosenValue1 = "Delux";
  String _chosenValue2 = "Free";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController regController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateofController = TextEditingController();
  final TextEditingController adminiController = TextEditingController();
  final TextEditingController adminiphoneController = TextEditingController();
  final TextEditingController accredController = TextEditingController();
  final TextEditingController ambuController = TextEditingController();
  final TextEditingController emerController = TextEditingController();
  final TextEditingController bookphController = TextEditingController();
  final TextEditingController opdbkController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController tpaController = TextEditingController();
  final TextEditingController bedsController = TextEditingController();
  final TextEditingController bedsController1 = TextEditingController();
  final TextEditingController bedsController2 = TextEditingController();
  final TextEditingController chargesController = TextEditingController();
  final TextEditingController chargesController1 = TextEditingController();
  final TextEditingController chargesController2 = TextEditingController();
  final TextEditingController dchargesController = TextEditingController();
  final TextEditingController nchargesController = TextEditingController();
  final TextEditingController pchargesController = TextEditingController();
  final TextEditingController phchargesController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController opdController = TextEditingController();
  final TextEditingController packController = TextEditingController();
  final TextEditingController amtController = TextEditingController();

  List<bool> _selected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<bool> facility = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> spl = [];
  List<String> fcl = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: (pageindex == 0)
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    color: Colors.redAccent,
                    iconSize: 30,
                  )
                : IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        pageindex--;
                      });
                    },
                    color: Colors.redAccent,
                    iconSize: 30,
                  ),
            actions: [
              Center(
                child: pageindex == 8
                    ? Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              pageindex == 8
                  ? IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        ApiService().hospitals(
                            nameController.text,
                            regController.text,
                            addressController.text,
                            dateofController.text,
                            adminiController.text,
                            adminiphoneController.text,
                            accredController.text,
                            ambuController.text,
                            emerController.text,
                            bookphController.text,
                            opdbkController.text,
                            Beds,
                            diagnosis,
                            health,
                            spl,
                            fcl,
                            doctorsList,
                            nursesList,
                            staffsList,
                            TPA);
                        AuthService()
                            .toast("Your Added Hospital Is Under Verification");
                        Navigator.pop(context);
                      },
                      color: Colors.redAccent,
                      iconSize: 30,
                    )
                  : IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() {
                            pageindex++;
                          });
                        }
                      },
                      color: Colors.redAccent,
                      iconSize: 30,
                    ),
            ],
            backgroundColor: Colors.white,
            title: Text(
              topics[pageindex],
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 22.0,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(child: changingpages(pageindex))),
    );
  }

  // ignore: missing_return
  Container changingpages(int pageindex) {
    switch (pageindex) {
      case 0:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Name"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Registration Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: regController,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Register Number"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Address",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Location"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Date of Incorporation",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: dateofController,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Name"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Administrator Name",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: adminiController,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Name"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Administrator Phone Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: adminiphoneController,
                  decoration: new InputDecoration(
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Name"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Accredition",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: accredController,
                  decoration: new InputDecoration(
                    errorBorder: OutlineInputBorder(),
                    disabledBorder: InputBorder.none,
                    // hintText: "Hospital Name"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      case 1:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ambulance Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: ambuController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Register Number"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Emergency Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: emerController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Location"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Booking Phone Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: bookphController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Name"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "OPD Booking Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: opdbkController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Name"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      case 2:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bed Details",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Free Beds",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      child: Text(
                        "Number of Beds",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: Text(
                        "Charges Per Day",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "    100% Free",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: bedsController,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: chargesController,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Concessional",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: bedsController1,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: chargesController1,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Special Beds",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
//
//                Container(
//                  child: ListView.builder(
//
//                      shrinkWrap: true,
//                      itemCount: specialBeds.length,
//                      itemBuilder: (_, index) => specialBeds[index]),
//                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 110,
                      height: 40,
                      child: Text(
                        "    Room Type",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: Text(
                        "Number of Beds",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: Text(
                        "Charges Per Day",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 110,
                      height: 40,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        value: _chosenValue1,
                        // underline: SizedBox(),
                        items: <String>[
                          'Economy',
                          'Economy Plus',
                          'Twin Delux',
                          'Delux',
                          'Junior-Suite',
                          'Grand-Suite'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue1 = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: bedsController2,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: chargesController2,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addSpecialBeds,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: specialBeds.length,
                      itemBuilder: (_, index) => specialBeds[index]),
                ),
              ],
            ),
          ),
        );
      case 3:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 110,
                      height: 40,
                      child: Text(
                        "Test Description",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: Text(
                        "Charges",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      height: 40,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: descController,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 40,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: opdController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addDiagnosisCharged,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: diagnosisCharge.length,
                      itemBuilder: (_, index) => diagnosisCharge[index]),
                ),
              ],
            ),
          ),
        );
      case 4:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 110,
                      height: 40,
                      child: Text(
                        "Package Name",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: Text(
                        "Amount",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      height: 40,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: packController,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 40,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: amtController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addHeathCheckup,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: healthCharges.length,
                      itemBuilder: (_, index) => healthCharges[index]),
                ),
              ],
            ),
          ),
        );
      case 5:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Specialities",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      ChoiceChip(
                        avatar: _selected[0] ? Icon(Icons.done) : null,
                        label: Text("Blood"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[0],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[0] = !_selected[0];
                            spl.contains("Blood")
                                ? spl.remove("Blood")
                                : spl.add("Blood");
                            print(spl.length);
                            print(spl.toString());
                          });
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[1] ? Icon(Icons.done) : null,
                        label: Text("Cardio"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[1],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[1] = !_selected[1];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Cardio")
                                ? spl.remove("Cardio")
                                : spl.add("Cardio");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[2] ? Icon(Icons.done) : null,
                        label: Text("Child"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[2],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[2] = !_selected[2];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Child")
                                ? spl.remove("Child")
                                : spl.add("Child");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[3] ? Icon(Icons.done) : null,
                        label: Text("Diabetic"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[3],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[3] = !_selected[3];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Diabetic")
                                ? spl.remove("Diabetic")
                                : spl.add("Diabetic");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[4] ? Icon(Icons.done) : null,
                        label: Text("ENT"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[4],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[4] = !_selected[4];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("ENT")
                                ? spl.remove("ENT")
                                : spl.add("ENT");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[5] ? Icon(Icons.done) : null,
                        label: Text("Gastro"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[5],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[5] = !_selected[5];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Gastro")
                                ? spl.remove("Gastro")
                                : spl.add("Gastro");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[6] ? Icon(Icons.done) : null,
                        label: Text("Gynac"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[6],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[6] = !_selected[6];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Gynac")
                                ? spl.remove("Gynac")
                                : spl.add("Gynac");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[7] ? Icon(Icons.done) : null,
                        label: Text("Lever & Kidney"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[7],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[7] = !_selected[7];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Lever & Kidney")
                                ? spl.remove("Lever & Kidney")
                                : spl.add("Lever & Kidney");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[8] ? Icon(Icons.done) : null,
                        label: Text("Ortho"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[8],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[8] = !_selected[8];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Neuro")
                                ? spl.remove("Neuro")
                                : spl.add("Neuro");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[9] ? Icon(Icons.done) : null,
                        label: Text("Ortho"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[9],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[9] = !_selected[9];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Ortho")
                                ? spl.remove("Ortho")
                                : spl.add("Ortho");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[10] ? Icon(Icons.done) : null,
                        label: Text("Skin"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[10],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[10] = !_selected[10];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Skin")
                                ? spl.remove("Skin")
                                : spl.add("Skin");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[11] ? Icon(Icons.done) : null,
                        label: Text("Uro"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[11],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[11] = !_selected[11];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Uro")
                                ? spl.remove("Uro")
                                : spl.add("Uro");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[12] ? Icon(Icons.done) : null,
                        label: Text("Others"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[12],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[12] = !_selected[12];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Others")
                                ? spl.remove("Others")
                                : spl.add("Others");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        );
      case 6:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Facilities",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      ChoiceChip(
                        avatar: facility[0] ? Icon(Icons.done) : null,
                        label: Text("Ambulance"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[0],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[0] = !facility[0];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Ambulance")
                                ? fcl.remove("Ambulance")
                                : fcl.add("Ambulance");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[1] ? Icon(Icons.done) : null,
                        label: Text("ATM"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[1],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[1] = !facility[1];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("ATM")
                                ? fcl.remove("ATM")
                                : fcl.add("ATM");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[2] ? Icon(Icons.done) : null,
                        label: Text("Blood Bank"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[2],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[2] = !facility[2];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Blood Bank")
                                ? fcl.remove("Blood Bank")
                                : fcl.add("Blood Bank");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[3] ? Icon(Icons.done) : null,
                        label: Text("Cafeteria"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[3],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[3] = !facility[3];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Cafeteria")
                                ? fcl.remove("Cafeteria")
                                : fcl.add("Cafeteria");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[4] ? Icon(Icons.done) : null,
                        label: Text("Dental Clinic"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[4],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[4] = !facility[4];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Dental Clinic")
                                ? fcl.remove("Dental Clinic")
                                : fcl.add("Dental Clinic");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[5] ? Icon(Icons.done) : null,
                        label: Text("Doctors availability 24/7"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[5],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[5] = !facility[5];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Doctors availability 24/7")
                                ? fcl.remove("Doctors availability 24/7")
                                : fcl.add("Doctors availability 24/7");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[6] ? Icon(Icons.done) : null,
                        label: Text("Gym"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[6],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[6] = !facility[6];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Gym")
                                ? fcl.remove("Gym")
                                : fcl.add("Gym");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[7] ? Icon(Icons.done) : null,
                        label: Text("Laundry Service"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[7],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[7] = !facility[7];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Laundry Service")
                                ? fcl.remove("Laundry Service")
                                : fcl.add("Laundry Service");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[8] ? Icon(Icons.done) : null,
                        label: Text("Maternity & NICU"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[8],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[8] = !facility[8];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Maternity & NICU")
                                ? fcl.remove("Maternity & NICU")
                                : fcl.add("Maternity & NICU");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[9] ? Icon(Icons.done) : null,
                        label: Text("Mini Kitchen"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[9],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[9] = !facility[9];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Mini Kitchen")
                                ? fcl.remove("Mini Kitchen")
                                : fcl.add("Mini Kitchen");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[10] ? Icon(Icons.done) : null,
                        label: Text("Operation Theatre"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[10],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[10] = !facility[10];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Operation Theatre")
                                ? fcl.remove("Operation Theatre")
                                : fcl.add("Operation Theatre");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[11] ? Icon(Icons.done) : null,
                        label: Text("Opthal Shop"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[11],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[11] = !facility[11];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Opthal Shop")
                                ? fcl.remove("Opthal Shop")
                                : fcl.add("Opthal Shop");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[12] ? Icon(Icons.done) : null,
                        label: Text("Parking"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[12],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[12] = !facility[12];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Parking")
                                ? fcl.remove("Parking")
                                : fcl.add("Parking");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[13] ? Icon(Icons.done) : null,
                        label: Text("Pharmacy"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[13],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[13] = !facility[13];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Pharmacy")
                                ? fcl.remove("Pharmacy")
                                : fcl.add("Pharmacy");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[14] ? Icon(Icons.done) : null,
                        label: Text("Sofa"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[14],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[14] = !facility[14];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Sofa")
                                ? fcl.remove("Sofa")
                                : fcl.add("Sofa");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[15] ? Icon(Icons.done) : null,
                        label: Text("Spa"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[15],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[15] = !facility[15];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Spa")
                                ? fcl.remove("Spa")
                                : fcl.add("Spa");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[16] ? Icon(Icons.done) : null,
                        label: Text("TV"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[16],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[16] = !facility[16];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("TV")
                                ? fcl.remove("TV")
                                : fcl.add("TV");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[17] ? Icon(Icons.done) : null,
                        label: Text("Video consultation"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[17],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[17] = !facility[17];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Video consultation")
                                ? fcl.remove("Video consultation")
                                : fcl.add("Video consultation");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[18] ? Icon(Icons.done) : null,
                        label: Text("Wifi"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[18],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[18] = !facility[18];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Wifi")
                                ? fcl.remove("Wifi")
                                : fcl.add("Wifi");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      case 7:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Doctors',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  ..._getDoctors(),
                  Text(
                    'Add Nurses',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  ..._getNurses(),
                  Text(
                    'Add Staffs',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  ..._getStaffs(),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        );
      case 8:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "TPA",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      //errorBorder: OutlineInputBorder(),
                      //disabledBorder: InputBorder.none,
                      // hintText: "Hospital Name"
                      ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  controller: tpaController,
                ),
                SizedBox(
                  height: 35,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addTPA,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: TPAInsurance.length,
                      itemBuilder: (_, index) => TPAInsurance[index]),
                ),
              ],
            ),
          ),
        );
    }
  }

  clearText() {
    descController.clear();
    opdController.clear();
    packController.clear();
    amtController.clear();
    tpaController.clear();
    bedsController2.clear();
    chargesController2.clear();
  }

  addSpecialBeds() {
    specialBeds.add(new AddSpecialBed(
        _chosenValue1, bedsController2.text, chargesController2.text));
    Beds.add({
      "roomType": _chosenValue1,
      "noOfBeds": bedsController2.text,
      "charges": chargesController2.text
    });
    print(Beds.toString());
    clearText();
  }

  addfreeBeds() {
    freebeds.add({
      "roomType": "100% free",
      "noOfBeds": bedsController.text,
      "charges": chargesController.text
    });
    conbeds.add({
      "roomType": "Concessional Beds",
      "noOfBeds": bedsController1.text,
      "charges": chargesController1.text
    });
    print(Beds.toString());
  }

  addDiagnosisCharged() {
    diagnosisCharge
        .add(new AddDiagnosisCharged(descController.text, opdController.text));
    diagnosis.add({
      "Test Description": descController.text,
      "Charges": opdController.text
    });
    print(diagnosis.toString());
    clearText();
  }


  addHeathCheckup() {
    healthCharges
        .add(new AddDiagnosisCharged(packController.text, amtController.text));
    health.add(
        {"PackageName": packController.text, "Amount": amtController.text});
    print(health.toString());
    clearText();
  }

  addTPA() {
    TPAInsurance.add(new AddInsurance(tpaController.text));
    TPA.add({
      "Insurance Name": tpaController.text,
    });
    print(TPA.toString());
    clearText();
  }

  List<Widget> _getDoctors() {
    List<Widget> doctorsTextFields = [];
    for (int i = 0; i < doctorsList.length; i++) {
      doctorsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: DoctorsTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButtonD(i == doctorsList.length - 1, i),
          ],
        ),
      ));
    }
    return doctorsTextFields;
  }

  List<Widget> _getNurses() {
    List<Widget> nursesTextFields = [];
    for (int i = 0; i < nursesList.length; i++) {
      nursesTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: NursesTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButtonN(i == nursesList.length - 1, i),
          ],
        ),
      ));
    }
    return nursesTextFields;
  }

  List<Widget> _getStaffs() {
    List<Widget> staffsTextFields = [];
    for (int i = 0; i < staffsList.length; i++) {
      staffsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: StaffsTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButtonS(i == staffsList.length - 1, i),
          ],
        ),
      ));
    }
    return staffsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButtonD(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          doctorsList.insert(0, null);
        } else
          doctorsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _addRemoveButtonN(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          nursesList.insert(0, null);
        } else
          nursesList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _addRemoveButtonS(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          staffsList.insert(0, null);
        } else
          staffsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class DoctorsTextFields extends StatefulWidget {
  final int index;
  DoctorsTextFields(this.index);
  @override
  _DoctorsTextFieldsState createState() => _DoctorsTextFieldsState();
}

class _DoctorsTextFieldsState extends State<DoctorsTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _AddHospitalState.doctorsList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _AddHospitalState.doctorsList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter Doctor\'s name'),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

class NursesTextFields extends StatefulWidget {
  final int index;
  NursesTextFields(this.index);
  @override
  _NursesTextFieldsState createState() => _NursesTextFieldsState();
}

class _NursesTextFieldsState extends State<NursesTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _AddHospitalState.nursesList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _AddHospitalState.nursesList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter Nurse\'s name'),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

class StaffsTextFields extends StatefulWidget {
  final int index;
  StaffsTextFields(this.index);
  @override
  _StaffsTextFieldsState createState() => _StaffsTextFieldsState();
}

class _StaffsTextFieldsState extends State<StaffsTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _AddHospitalState.staffsList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _AddHospitalState.staffsList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter Staff\'s name'),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
