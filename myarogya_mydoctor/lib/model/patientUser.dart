import 'package:flutter/cupertino.dart';

import 'MyPatient.dart';

class PatientUser{
  String Name;
  String category;
  String mobile;
  String Age;
  String Gender;
  String image;
  String emailId;
  List<MyDoctors> mydoctors;

  PatientUser._({this.Name, this.category,this.mobile,this.Age
    ,this.Gender,this.image,this.emailId,this.mydoctors});

  factory PatientUser.fromJson(dynamic json) {
    // var mydocs = json['myDoctor'] as List;
    // List<MyDoctors> _mydocs = mydocs?.map((e) => MyDoctors.fromJson(json))?.toList()??[];
    return new PatientUser._(
      Name: json['Name'] as String??"",
      category: json['category'] as String??"",
      mobile: json['mobile'] as String??"",
      Age: json['Age'] as String??"",
      Gender: json['Gender'] as String??"",
      image: json['image'] as String??"",
      emailId: json['emailId'] as String??"",
      // mydoctors: _mydocs,

    );
  }
}

class MyDoctors{
  String name;
  String number;

  MyDoctors._({this.name, this.number});
  factory MyDoctors.fromJson(dynamic json) {

    return new MyDoctors._(
      name: json['name'] as String??"",
      number: json['phone'] as String??"",
    );
  }
}
