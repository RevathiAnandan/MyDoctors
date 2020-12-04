class Booking{
  String bookingNumber;
  String userNumber;
  String status;
  String BookingDate;
  String DischargeDate;
  List<Bookdetails> bookdetails;


  Booking._({this.bookingNumber,this.BookingDate, this.userNumber,this.status,this.bookdetails,this.DischargeDate});

  factory Booking.fromJson(dynamic json) {
    var bking = json["Booking details"] as List;
    List<Bookdetails> _BKD = bking.map((tagJson) => Bookdetails.fromJson(tagJson)).toList();
    return new Booking._(
      bookdetails: _BKD,
      bookingNumber: json['BookingNumber'] as String,
      userNumber: json['UserNumber'] as String,
      status: json['Status'] as String,
      BookingDate: json['BookingDate'] as String,
      DischargeDate: json['DischargeDate'] as String,
    );
  }
}

class Bookdetails {
  String roomType;
  String noOfBeds;
  String charges;
  String packName;

  Bookdetails._({this.roomType,this.noOfBeds,this.charges,this.packName});

  factory Bookdetails.fromJson(dynamic json){

    if (json['roomType']!=null) {
      return Bookdetails._(
            roomType: json['roomType'] as String,
            noOfBeds: json['noOfBeds'] as String,
            charges: json['charges'] as String,

          );
    } else {
      return Bookdetails._(
        roomType: json['Type'] as String,
        charges: json['charges'] as String,
        packName: json['packName'] as String,
      );
    }
  }
}
