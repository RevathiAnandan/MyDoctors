import 'package:flutter/material.dart';



class Labtests extends StatefulWidget {
  @override
  _LabtestsState createState() => _LabtestsState();
}

class _LabtestsState extends State<Labtests> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 135,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 160,
              child: Text(
                'Lab Tests',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              // padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  Positioned(
                    left: 300,
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
          ),
        ],
      ),
    );
  }
}
