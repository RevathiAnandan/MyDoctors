import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MedicineTests extends StatefulWidget {
  @override
  _MedicineTestsState createState() => _MedicineTestsState();
}

class _MedicineTestsState extends State<MedicineTests> {
  

  
  final myController = TextEditingController();

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

  DateTime date1;

  DateTime date2;

  DateTime date3;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 235,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Medicine/Tests',
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                Positioned(
                  left: 280,
                  top: 50,
                  child: MaterialButton(
                    elevation: 8,
                    onPressed: () {},
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
                                        controller: myController,
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
                                            fontSize: 25,
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
                                        //controller: myController,
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
                                            fontSize: 25,
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
                                        // controller: myController,
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
                                            fontSize: 25,
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
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            //controller: myController,
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
                                fontSize: 25,
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
                        items: <String>['Before Food', 'After Food']
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
    );
  }
}
