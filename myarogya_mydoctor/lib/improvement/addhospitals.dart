import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/widget/filterChipWidget.dart';

import 'addSpecialBed.dart';

class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {

  final _formKey = GlobalKey<FormState>();
  List<Widget> specialBeds = [];
  List Beds = [];
  List topics = ["Hospital Details","Important Numbers","Room Tariff","Diagnosis Charges","Health Check","Speciality","Facility","Staff Details","Insurance","Packages"];
  int pageindex=0;
  String _chosenValue1 = "ICU";
  String _chosenValue2 = "Free";
  final TextEditingController roomController = TextEditingController();
  final TextEditingController bedsController = TextEditingController();
  final TextEditingController chargesController = TextEditingController();
  final TextEditingController dchargesController = TextEditingController();
  final TextEditingController nchargesController = TextEditingController();
  final TextEditingController pchargesController = TextEditingController();
  final TextEditingController phchargesController = TextEditingController();

  List<bool> _selected =[false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
  List<bool> facility = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false ];
  List <String> spl=[];
  List <String> fcl=[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: (pageindex==0)?
            IconButton(
              icon: Icon(Icons.close),
              onPressed: ()=>Navigator.pop(context),
              color: Colors.redAccent,
              iconSize: 30,
            ):IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                setState(() {
                  pageindex--;
                });
              },
              color: Colors.redAccent,
              iconSize: 30,
            ),
            actions: [
              Center(
                child: Text("Next",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: (){
                  setState(() {
                    pageindex++;
                  });
                },
                color: Colors.redAccent,
                iconSize: 30,
              ),
            ],
            backgroundColor: Colors.white,
            title:
            Text(topics[pageindex],
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 22.0,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
              child:changingpages(pageindex)
          )
      ),
    );
  }
  // ignore: missing_return
  Container changingpages(int pageindex){
    switch(pageindex) {
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
                Text("Name",
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
                SizedBox(
                  height: 35,
                ),
                Text("Registration Number",
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
                    errorBorder: OutlineInputBorder(),
                    disabledBorder: InputBorder.none,
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
                Text("Address",
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
                    errorBorder: OutlineInputBorder(),
                    disabledBorder: InputBorder.none,
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
                Text("Date of Incorporation",
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
                SizedBox(
                  height: 35,
                ),
                Text("Administrator Name",
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
                SizedBox(
                  height: 35,
                ),
                Text("Administrator Phone Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
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
                  height:10,
                ),

                Text("Ambulance Number",
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
                    errorBorder: OutlineInputBorder(),
                    disabledBorder: InputBorder.none,
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
                Text("Emergency Number",
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
                    errorBorder: OutlineInputBorder(),
                    disabledBorder: InputBorder.none,
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
                Text("Booking Phone Number",
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
                SizedBox(
                  height: 35,
                ),
                Text("OPD Booking Number",
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
                SizedBox(
                  height: 10,
                ),
                // Text("TPA",
                //   style: TextStyle(
                //     color: Colors.redAccent,
                //     fontSize: 18,
                //     fontFamily: 'Lato',
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //   maxLines: 3,
                //   decoration: new InputDecoration(
                //     border: OutlineInputBorder(),
                //     // focusedBorder: InputBorder.none,
                //     // enabledBorder: InputBorder.none,
                //     errorBorder: OutlineInputBorder(),
                //     disabledBorder: InputBorder.none,
                //     // hintText: "Hospital Register Number"
                //   ),
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontFamily: 'Lato',
                //   ),
                //   validator: (value) {
                //     if (value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                // ),
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
                Text("Bed Details",
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
                Text("Free Beds",
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 110,
                      height: 40,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        value: _chosenValue2,
                        // underline: SizedBox(),
                        items: <String>['Free','Concessional']
                            .map<DropdownMenuItem<String>>((String value) {
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
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
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
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
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
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 110,
                      height: 40,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        value: _chosenValue2,
                        // underline: SizedBox(),
                        items: <String>['Free','Concessional']
                            .map<DropdownMenuItem<String>>((String value) {
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
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
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
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
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
                  height: 30,
                ),
                Text("Special Beds",
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

                Container(
                  child: ListView.builder(

                      shrinkWrap: true,
                      itemCount: specialBeds.length==null?0:specialBeds.length,
                      itemBuilder: (_, index) => specialBeds[index]),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 110,
                      height: 40,
                      child: Text("    Room Type",
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
                      child: Text("Number of Beds",
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
                      child: Text("Charges Per Day",
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
                          side: BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        value: _chosenValue1,
                        // underline: SizedBox(),
                        items: <String>['ICU', 'Delux','Semi Delux','Special']
                            .map<DropdownMenuItem<String>>((String value) {
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
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
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
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
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
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child:Container(
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
                Text("Other Charges",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width:70,
                      height: 40,
                      child: Text("Doctor",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 40,
                      child: Text("Nurse",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 40,
                      child: Text("Pathology",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 40,
                      child: Text("Pharmacy",
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
                      width: 70,
                      height: 40,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: dchargesController,
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
                      width: 70,
                      height: 40,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: nchargesController,
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
                      width: 70,
                      height: 40,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: pchargesController,
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
                      width: 70,
                      height: 40,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(),
                          disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: phchargesController,
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
                Text("Specialities",
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
                        avatar: _selected[0]? Icon(Icons.done):null,
                        label: Text("Blood"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[0],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[0] = !_selected[0];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Blood")
                                ? spl.remove("Blood")
                                : spl.add("Blood");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[1]? Icon(Icons.done):null,
                        label: Text("Cardio"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[1],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[2]? Icon(Icons.done):null,
                        label: Text("Child"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[2],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[3]? Icon(Icons.done):null,
                        label: Text("Diabetic"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[3],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[4]? Icon(Icons.done):null,
                        label: Text("ENT"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[4],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[5]? Icon(Icons.done):null,
                        label: Text("Gastro"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[5],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[6]? Icon(Icons.done):null,
                        label: Text("Gynac"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[6],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[7]? Icon(Icons.done):null,
                        label: Text("Lever & Kidney"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[7],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[8]? Icon(Icons.done):null,
                        label: Text("Ortho"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[8],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[9]? Icon(Icons.done):null,
                        label: Text("Ortho"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[9],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[10]? Icon(Icons.done):null,
                        label: Text("Skin"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[10],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[11]? Icon(Icons.done):null,
                        label: Text("Uro"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[11],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: _selected[12]? Icon(Icons.done):null,
                        label: Text("Others"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: _selected[12],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
      case 4:
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Facilities",
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
                        avatar: facility[0]? Icon(Icons.done):null,
                        label: Text("Ambulance"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[0],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[1]? Icon(Icons.done):null,
                        label: Text("ATM"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[1],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[2]? Icon(Icons.done):null,
                        label: Text("Blood Bank"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[2],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[3]? Icon(Icons.done):null,
                        label: Text("Cafeteria"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[3],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[4]? Icon(Icons.done):null,
                        label: Text("Dental Clinic"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[4],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[5]? Icon(Icons.done):null,
                        label: Text("Doctors availability 24/7"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[5],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[6]? Icon(Icons.done):null,
                        label: Text("Gym"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[6],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[7]? Icon(Icons.done):null,
                        label: Text("Laundry Service"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[7],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[8]? Icon(Icons.done):null,
                        label: Text("Maternity & NICU"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[8],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[9]? Icon(Icons.done):null,
                        label: Text("Mini Kitchen"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[9],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[10]? Icon(Icons.done):null,
                        label: Text("Operation Theatre"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[10],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[11]? Icon(Icons.done):null,
                        label: Text("Opthal Shop"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[11],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar:facility[12]? Icon(Icons.done):null,
                        label: Text("Parking"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[12],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[13]? Icon(Icons.done):null,
                        label: Text("Pharmacy"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[13],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[14]? Icon(Icons.done):null,
                        label: Text("Sofa"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[14],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[15]? Icon(Icons.done):null,
                        label: Text("Spa"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[15],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[16]? Icon(Icons.done):null,
                        label: Text("TV"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[16],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[17]? Icon(Icons.done):null,
                        label: Text("Video consultation"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[17],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
                        avatar: facility[18]? Icon(Icons.done):null,
                        label: Text("Wifi"),
                        labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                        selected: facility[18],
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0),),
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
      case 5:
        return new Container();
      case 6:
        return new Container();
      case 7:
        return new Container();

    }
  }




  addSpecialBeds() {
    specialBeds.add(new AddSpecialBed(_chosenValue1,bedsController.text,chargesController.text));
    Beds.add(
        {
          "roomType": _chosenValue1,
          "noOfBeds": bedsController.text,
          "charges": chargesController.text
        }
    );
    print(Beds.toString());
  }
}
