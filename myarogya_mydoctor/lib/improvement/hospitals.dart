import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hospitals extends StatefulWidget {
  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "  Hospitals",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    background: Image.network(
                      "https://www.healthcareitnews.com/sites/hitn/files/pexels-pixabay-236380.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: [
                    Center(
                      child: Text(
                        '400+     ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ];
            },
            body: ListView(children: [
              Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                //padding: EdgeInsets.all(15),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: NetworkImage(
                                    "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                  ),
                                  width: 150,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thiruvengadam Hospital',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Lato'),
                                  ),
                                  Text(
                                    'Guindy, Chennai',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'Lato'),
                                  ),
                                  Image.network(
                                    "https://lh3.googleusercontent.com/proxy/lqTL9l33KeXONHOAlq1uejJcCRrLC7QR2aQn4AhmRfnmzX383QpKkTUips-4y7cq-JWmAmdPj7vHvXUFNYr0IFUWUhxas_-HO47kVQkMT_UkIN0f1MTsJy8wqZoshDaM",
                                    width: 100,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                      Radius.circular(10))),
                                          color: Colors.red,
                                          child: Center(
                                            child: Text('8.0',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //Icon(Icons.local_hospital_outlined),
                                      Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    " Rs.5000",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 18,fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    " No Prepayment needed",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: NetworkImage(
                                    "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                  ),
                                  width: 150,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thiruvengadam Hospital',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Lato'),
                                  ),
                                  Text(
                                    'Guindy, Chennai',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'Lato'),
                                  ),
                                  Image.network(
                                    "https://lh3.googleusercontent.com/proxy/lqTL9l33KeXONHOAlq1uejJcCRrLC7QR2aQn4AhmRfnmzX383QpKkTUips-4y7cq-JWmAmdPj7vHvXUFNYr0IFUWUhxas_-HO47kVQkMT_UkIN0f1MTsJy8wqZoshDaM",
                                    width: 100,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                  Radius.circular(10))),
                                          color: Colors.red,
                                          child: Center(
                                            child: Text('8.0',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //Icon(Icons.local_hospital_outlined),
                                      Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    " Rs.5000",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 18,fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    " No Prepayment needed",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),Container(
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: NetworkImage(
                                    "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                  ),
                                  width: 150,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thiruvengadam Hospital',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Lato'),
                                  ),
                                  Text(
                                    'Guindy, Chennai',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'Lato'),
                                  ),
                                  Image.network(
                                    "https://lh3.googleusercontent.com/proxy/lqTL9l33KeXONHOAlq1uejJcCRrLC7QR2aQn4AhmRfnmzX383QpKkTUips-4y7cq-JWmAmdPj7vHvXUFNYr0IFUWUhxas_-HO47kVQkMT_UkIN0f1MTsJy8wqZoshDaM",
                                    width: 100,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                  Radius.circular(10))),
                                          color: Colors.red,
                                          child: Center(
                                            child: Text('8.0',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //Icon(Icons.local_hospital_outlined),
                                      Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    " Rs.5000",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 18,fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    " No Prepayment needed",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),Container(
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: NetworkImage(
                                    "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                  ),
                                  width: 150,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thiruvengadam Hospital',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Lato'),
                                  ),
                                  Text(
                                    'Guindy, Chennai',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'Lato'),
                                  ),
                                  Image.network(
                                    "https://lh3.googleusercontent.com/proxy/lqTL9l33KeXONHOAlq1uejJcCRrLC7QR2aQn4AhmRfnmzX383QpKkTUips-4y7cq-JWmAmdPj7vHvXUFNYr0IFUWUhxas_-HO47kVQkMT_UkIN0f1MTsJy8wqZoshDaM",
                                    width: 100,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                  Radius.circular(10))),
                                          color: Colors.red,
                                          child: Center(
                                            child: Text('8.0',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //Icon(Icons.local_hospital_outlined),
                                      Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    " Rs.5000",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 18,fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    " No Prepayment needed",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),Container(
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: NetworkImage(
                                    "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                  ),
                                  width: 150,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thiruvengadam Hospital',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Lato'),
                                  ),
                                  Text(
                                    'Guindy, Chennai',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'Lato'),
                                  ),
                                  Image.network(
                                    "https://lh3.googleusercontent.com/proxy/lqTL9l33KeXONHOAlq1uejJcCRrLC7QR2aQn4AhmRfnmzX383QpKkTUips-4y7cq-JWmAmdPj7vHvXUFNYr0IFUWUhxas_-HO47kVQkMT_UkIN0f1MTsJy8wqZoshDaM",
                                    width: 100,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                  Radius.circular(10))),
                                          color: Colors.red,
                                          child: Center(
                                            child: Text('8.0',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //Icon(Icons.local_hospital_outlined),
                                      Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    " Rs.5000",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 18,fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    " No Prepayment needed",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),Container(
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: NetworkImage(
                                    "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                  ),
                                  width: 150,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thiruvengadam Hospital',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Lato'),
                                  ),
                                  Text(
                                    'Guindy, Chennai',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'Lato'),
                                  ),
                                  Image.network(
                                    "https://lh3.googleusercontent.com/proxy/lqTL9l33KeXONHOAlq1uejJcCRrLC7QR2aQn4AhmRfnmzX383QpKkTUips-4y7cq-JWmAmdPj7vHvXUFNYr0IFUWUhxas_-HO47kVQkMT_UkIN0f1MTsJy8wqZoshDaM",
                                    width: 100,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                  Radius.circular(10))),
                                          color: Colors.red,
                                          child: Center(
                                            child: Text('8.0',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //Icon(Icons.local_hospital_outlined),
                                      Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    " Rs.5000",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 18,fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    " No Prepayment needed",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),Container(
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: MediaQuery.of(context).size.width * 91 / 100,
                      child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: NetworkImage(
                                    "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                  ),
                                  width: 150,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thiruvengadam Hospital',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Lato'),
                                  ),
                                  Text(
                                    'Guindy, Chennai',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'Lato'),
                                  ),
                                  Image.network(
                                    "https://lh3.googleusercontent.com/proxy/lqTL9l33KeXONHOAlq1uejJcCRrLC7QR2aQn4AhmRfnmzX383QpKkTUips-4y7cq-JWmAmdPj7vHvXUFNYr0IFUWUhxas_-HO47kVQkMT_UkIN0f1MTsJy8wqZoshDaM",
                                    width: 100,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                  Radius.circular(10))),
                                          color: Colors.red,
                                          child: Center(
                                            child: Text('8.0',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //Icon(Icons.local_hospital_outlined),
                                      Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    " Rs.5000",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 18,fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    " No Prepayment needed",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
