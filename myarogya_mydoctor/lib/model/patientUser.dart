import 'package:flutter/cupertino.dart';

import 'MyPatient.dart';

class PatientUser{
  String Name;
  String category;
  String mobile;
  String Age;
  String Gender;
  String image;

  PatientUser._({this.Name, this.category,this.mobile,this.Age
    ,this.Gender,this.image});

  factory PatientUser.fromJson(dynamic json) {

    return new PatientUser._(
      Name: json['Name'] as String,
      category: json['category'] as String,
      mobile: json['mobile'] as String,
      Age: json['Age'] as String,
      Gender: json['Gender'] as String,
      image: json['image'] as String,
    );
  }
}
