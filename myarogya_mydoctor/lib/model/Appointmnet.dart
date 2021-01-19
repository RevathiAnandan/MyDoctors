class Appointmnet{
  String doctorMobile;
  String status;
  String patientMobile;
  String doctorName;
  String date;
  int Token;
  String BookingTime;
  String Index;
  String patientname;
  String patientage;
  String patientgender;

  Appointmnet._({this.doctorMobile, this.status,this.patientMobile,this.doctorName,this.date,this.Token,this.BookingTime,this.Index,this.patientname,this.patientage,this.patientgender});

  factory Appointmnet.fromJson(dynamic json) {

    if(json['Token'] != null && json['BookingTime'] != null){
      return new Appointmnet._(
        doctorMobile: json['doctorMobile'] as String??"",
        patientMobile: json['patientMobile'] as String??"",
        doctorName: json['doctorName'] as String??"",
        status: json['status'] as String??"",
        date: json['date'] as String??"",
        BookingTime: json['BookingTime'] as String??"",
        Index: json['Index'] as String??"",
        Token: json['Token'] as int??1,
        patientname: json['patientName'] as String??"",
        patientage: json['patientAge'] as String??"",
        patientgender: json['patientGender'] as String??"",
      );
    }else
    {
      return new Appointmnet._(
      doctorMobile: json['doctorMobile'] as String??"",
      patientMobile: json['patientMobile'] as String??"",
      doctorName: json['doctorName'] as String??"",
      status: json['status'] as String??"",
      Index: json['Index'] as String??"",
      date: json['date'] as String??"",  BookingTime: json['BookingTime'] as String??"",
        Token: json['Token'] as int??1,
    );
    }
  }
}
