class Appointmnet{
  String doctorMobile;
  String status;
  String patientMobile;
  String patientName;
  String date;
  int Token;
  String BookingTime;

  Appointmnet._({this.doctorMobile, this.status,this.patientMobile,this.patientName,this.date,this.Token,this.BookingTime});

  factory Appointmnet.fromJson(dynamic json) {

    if(json['Token'] != null && json['BookingTime'] != null){
      return new Appointmnet._(
        doctorMobile: json['doctorMobile'] as String,
        patientMobile: json['patientMobile'] as String,
        patientName: json['patientName'] as String,
        status: json['status'] as String,
        date: json['date'] as String,
        BookingTime: json['BookingTime'] as String,
        Token: json['Token'] as int,
      );
    }else
    {
      return new Appointmnet._(
      doctorMobile: json['doctorMobile'] as String,
      patientMobile: json['patientMobile'] as String,
      patientName: json['patientName'] as String,
      status: json['status'] as String,
      date: json['date'] as String,  BookingTime: json['BookingTime'] as String,
        Token: json['Token'] as int,
    );
    }
  }
}
