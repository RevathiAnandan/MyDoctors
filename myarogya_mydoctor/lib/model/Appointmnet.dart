class Appointmnet{
  String doctorMobile;
  String status;
  String patientMobile;
  String patientName;
  String date;

  Appointmnet._({this.doctorMobile, this.status,this.patientMobile,this.patientName,this.date});

  factory Appointmnet.fromJson(dynamic json) {

    return new Appointmnet._(
      doctorMobile: json['doctorMobile'] as String,
      patientMobile: json['patientMobile'] as String,
      patientName: json['patientName'] as String,
      status: json['status'] as String,
      date: json['date'] as String,
    );
  }
}
