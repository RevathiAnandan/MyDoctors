import 'MyPatient.dart';

class DoctorUser{
  String Name;
  String category;
  String mobile;
  String degree;
  String emailId;
  String hospitalName;
  String registerId;
  String specialist;
  List<MyPatient> myPatient;
  String EndTime;
  String StartTime;
  String Intervals;
  String Address;

  DoctorUser._({this.Name, this.category,this.mobile,this.myPatient,this.degree,this.emailId,this.hospitalName,this.registerId,this.specialist,this.EndTime,this.Address,this.Intervals,this.StartTime});

  factory DoctorUser.fromJson(dynamic json) {
    var tagObjsJson = json['myPatient'] as List;
    List<MyPatient> _tags = tagObjsJson.map((tagJson) => MyPatient.fromJson(tagJson)).toList();
    return new DoctorUser._(
      Name: json['Name'] as String,
      category: json['category'] as String,
      mobile: json['mobile'] as String,
      myPatient: _tags,
      degree: json['degree'] as String,
      emailId: json['emailId'] as String,
      hospitalName: json['hospitalName'] as String,
      registerId: json['registerId'] as String,
      specialist: json['specialist'] as String,
      EndTime: json['End Time'] as String,
      StartTime: json['Start Time'] as String,
      Intervals: json['Consulting Interval'] as String,
      Address: json['Hospital Address'] as String,
    );
  }
}
