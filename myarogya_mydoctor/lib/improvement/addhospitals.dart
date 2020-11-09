import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/widget/filterChipWidget.dart';

class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {

  final _formKey = GlobalKey<FormState>();
  int pageindex=0;
  String _chosenValue1 = "General";
  String _chosenValue2 = "General";
  bool _selected = false;

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
          title: Text("Hospital Details",
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
  changingpages(int pageindex){
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
                Text("Hospital Name",
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
                Text("Hospital Registration Number",
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
                Text("Hospital Address",
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
                Text("Adminstrator Phone Number",
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
                Text("Bed Details",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 25,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
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
                // SizedBox(
                //   height: 15,
                // ),
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
                        items: <String>['ICU', 'Delux','Semi Delux','Special','General','Free']
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
                  height: 15,
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
                        items: <String>['ICU', 'Delux','Semi Delux','Special','General','Free']
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
                Text("Other Details",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 25,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
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
//                TextFormField(
//                  maxLines: 3,
//                  decoration: new InputDecoration(
//                    border: OutlineInputBorder(),
//                    // focusedBorder: InputBorder.none,
//                    // enabledBorder: InputBorder.none,
//                    errorBorder: OutlineInputBorder(),
//                    disabledBorder: InputBorder.none,
//                    // hintText: "Hospital Register Number"
//                  ),
//                  style: TextStyle(
//                    fontSize: 18,
//                    fontFamily: 'Lato',
//                  ),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter some text';
//                    }
//                    return null;
//                  },
//                ),
              Container(
              child: Wrap(
                spacing: 5.0,
                runSpacing: 3.0,
                children: <Widget>[
                  filterChipWidget(chipName:"Cardio"),
                  filterChipWidget(chipName:"Neuro"),
                  filterChipWidget(chipName:"Ortho"),
                  filterChipWidget(chipName:"Gastro"),
                  filterChipWidget(chipName:"Uro"),
                  filterChipWidget(chipName:"Skin"),
                  filterChipWidget(chipName:"Blood"),
                  filterChipWidget(chipName:"ENT"),
                  filterChipWidget(chipName:"Gynac"),
                  filterChipWidget(chipName:"Child"),
                  filterChipWidget(chipName:"Lever & Kidney"),
                  filterChipWidget(chipName:"Others"),
                ],
              ),
              ),

                SizedBox(
                  height: 35,
                ),
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
                TextFormField(
                  maxLines: 3,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
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
                SizedBox(
                  height:10,
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
                Text("TPA",
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
                TextFormField(
                  maxLines: 3,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
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
              ],
            ),
          ),
        );
    }
  }

  Widget filterDetails(String chipName){
    return FilterChip(
        selected: _selected,
        label: Text(chipName),
        onSelected: (bool selected) {
          setState(() {
            _selected = !_selected;
          });
        }
    );
  }
}
