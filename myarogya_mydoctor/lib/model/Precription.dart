
import 'package:myarogya_mydoctor/model/labTest.dart';

import 'medicine.dart';

class Prescription{
  String patientMobile;
  String patientName;
  String doctorMobile;
  String diagnosis;
  String bp;
  String bpHigh;
  String weight;
  String pulse;
  String nextVisit;
  String date;
  List<Details> details;
  String labTest;

  Prescription._({this.patientMobile, this.patientName,this.doctorMobile,this.diagnosis,this.bp,this.bpHigh,this.weight,this.pulse,this.nextVisit,this.date,this.details,this.labTest});

  factory Prescription.fromJson(dynamic json) {
    var tagObjsJson = json['details'] as List;
//    var tagObjsJson1 = json['labTest'] as List;
    List<Details> _tags = tagObjsJson.map((tagJson) => Details.fromJson(tagJson)).toList();
//    List<LabTest> _tags1 = tagObjsJson1.map((tag) => LabTest.fromJson(tag)).toList();


      return new Prescription._(
        patientMobile: json['patientMobile'] as String,
        patientName: json['patientName'] as String,
        doctorMobile: json['doctorMobile'] as String,
        details: _tags,
        labTest: json['labTest'] as String,
        diagnosis: json['diagnosis'] as String,
        bp: json['bp'] as String,
        bpHigh: json['bpHigh'] as String,
        weight: json['weight'] as String,
        pulse: json['pulse'] as String,
        nextVisit: json['nextVisit'] as String,
        date: json['date'] as String,
      );
//    }else{
//
//      return new Prescription._(
//        patientMobile: json['patientMobile'] as String,
//        patientName: json['patientName'] as String,
//        doctorMobile: json['doctorMobile'] as String,
//        details: _tags,
//        diagnosis: json['diagnosis'] as String,
//        bp: json['bp'] as String,
//        bpHigh: json['bpHigh'] as String,
//        weight: json['weight'] as String,
//        pulse: json['pulse'] as String,
//        nextVisit: json['nextVisit'] as String,
//        date: json['date'] as String,
//      );
//    }

  }
}
