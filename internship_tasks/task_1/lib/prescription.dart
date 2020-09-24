import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 230,
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          'AI AASHIRWAD CLINIC',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 50,
                          width: 150,
                          child: Text('''           Mob:9825353585
                       7080111264
                          '''),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                        'Door no. 5, Unique Home, Tirupathi& Virar[Weif], Palghar - 401 303'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text('About goes here'),
                      ),
                      Container(
                        child: Text('Consulting hours goes here'),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Patient Name:__________, M, 38,9067060552',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Date: 5 Aug 2020(Today) Always',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'LOGO',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/3),
                columnWidths: {0: FractionColumnWidth(.25),1: FractionColumnWidth(.35),2:FractionColumnWidth(.2),3: FractionColumnWidth(2)},
                border: TableBorder.all(color: Colors.black),
                children: [
                 TableRow(
                   children: [
                     TableCell(child: Text('Diagnosis')),
                     TableCell(
                       child: Text('Medicine/Tests'),
                     ),
                     TableCell(child: Text('Medicine Dose')),
                     TableCell(
                       child: Text(''' Continue
 For'''),
                     ),
                   ]
                 ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(''
                    'Prescribed on 5 Aug 2020, 12.20.22 PM',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
