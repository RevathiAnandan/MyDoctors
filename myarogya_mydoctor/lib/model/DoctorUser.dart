import 'MyPatient.dart';

class DoctorUser {
  String id;
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
  String image;
  String Hospital_Address;
  String Qrcode;
  String mstarttym;
  String mendtym;
  String estarttym;
  String eendtymm;
  String sstarttym;
  String sendtym;
  String date5;

  DoctorUser._(
      {this.id,
      this.Name,
      this.category,
      this.mobile,
      this.degree,
      this.emailId,
      this.hospitalName,
      this.registerId,
      this.specialist,
      this.EndTime,
      this.image,
      this.Intervals,
      this.StartTime,
      this.Hospital_Address,
      this.myPatient,
      this.Qrcode,
      this.mstarttym,
      this.mendtym,
      this.estarttym,
      this.eendtymm,
      this.sstarttym,
      this.sendtym,
      this.date5});

  factory DoctorUser.fromJson(dynamic json) {
    // var tagObjsJson = json['myPatient'] as List;
    // List<MyPatient> _tags = tagObjsJson.map((tagJson) => MyPatient.fromJson(tagJson)).toList();
    return new DoctorUser._(
      id: json['id'] as String??"",
      Name: json['Name'] as String??"",
      category: json['category'] as String??"",
      mobile: json['mobile'] as String??"",
      // myPatient: _tags,
      degree: json['degree'] as String??"",
      emailId: json['emailId'] as String??"",
      hospitalName: json['hospitalName'] as String??"",
      registerId: json['registerId'] as String??"",
      specialist: json['specialist'] as String??"",
      EndTime: json['End Time'] as String??"",
      StartTime: json['Start Time'] as String??"",
      Intervals: json['Consulting Interval'] as String??"",
      Hospital_Address: json['Hospital Address'] as String??"",
      image: json['image'] as String??"",
      Qrcode: json['QrCode'] as String??"",
      mstarttym: json['Morning Start Time'] as String??"",
      mendtym: json['Morning End Time'] as String??"",
      estarttym: json['Evening Start Time'] as String??"",
      eendtymm: json['Evening End Time'] as String??"",
      sstarttym: json['Sunday Start Time'] as String??"",
      sendtym: json['Sunday End Time'] as String??"",
      date5: json['Date of Registration'] as String??"",
    );
  }
}
