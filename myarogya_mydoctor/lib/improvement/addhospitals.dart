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
  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = false;
  bool _selected4 = false;
  bool _selected5 = false;
  bool _selected6 = false;
  bool _selected7 = false;
  bool _selected8 = false;
  bool _selected9 = false;
  bool _selected10 = false;
  bool _selected11 = false;
  bool _selected12 = false;
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
                spl.clear();
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
                ),Text("Date of Incorporation",
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
                  ChoiceChip(
              avatar: _selected? Icon(Icons.done):null,
                label: Text("Gastro"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected = !_selected;
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
              avatar: _selected1? Icon(Icons.done):null,
                label: Text("Neuro"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected1,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected1 = !_selected1;
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
              avatar: _selected2? Icon(Icons.done):null,
                label: Text("Ortho"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected2,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected2 = !_selected2;
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
              avatar: _selected3? Icon(Icons.done):null,
                label: Text("Uro"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected3,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected3 = !_selected3;
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
              avatar: _selected4? Icon(Icons.done):null,
                label: Text("Skin"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected4,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected4 = !_selected4;
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
              avatar: _selected5? Icon(Icons.done):null,
                label: Text("Blood"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected5,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected5 = !_selected5;
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
              avatar: _selected12? Icon(Icons.done):null,
                label: Text("Cardio"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected12,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected12 = !_selected12;
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
              avatar: _selected6? Icon(Icons.done):null,
                label: Text("ENT"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected1,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected6 = !_selected6;
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
              avatar: _selected7? Icon(Icons.done):null,
                label: Text("Gynac"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected1,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected7 = !_selected7;
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
              avatar: _selected8? Icon(Icons.done):null,
                label: Text("Child"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected1,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected8 = !_selected8;
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
              avatar: _selected9? Icon(Icons.done):null,
                label: Text("Lever & Kidney"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected9,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected9 = !_selected9;
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
              avatar: _selected10? Icon(Icons.done):null,
                label: Text("Diabetic"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected10,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected10 = !_selected10;
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
              avatar: _selected11? Icon(Icons.done):null,
                label: Text("Others"),
                labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
                selected: _selected11,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),),
                backgroundColor: Color(0xffededed),

                onSelected: (bool selected) {
                  setState(() {
                    _selected11 = !_selected11;
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

}
