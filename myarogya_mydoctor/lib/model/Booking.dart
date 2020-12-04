class Booking{
  String bookingNumber;
  String userNumber;
  String status;
  String BookingDate;
  List<Bookdetails> bookdetails;


  Booking._({this.bookingNumber,this.BookingDate, this.userNumber,this.status,this.bookdetails});

  factory Booking.fromJson(dynamic json) {
    var bking = json["Booking details"] as List;
    List<Bookdetails> _BKD = bking.map((tagJson) => Bookdetails.fromJson(tagJson)).toList();
    return new Booking._(
      bookdetails: _BKD,
      bookingNumber: json['BookingNumber'] as String,
      userNumber: json['UserNumber'] as String,
      status: json['Status'] as String,
      BookingDate: json['BookingDate'] as String,
    );
  }
}

class Bookdetails {
  String roomType;
  String noOfBeds;
  String charges;

  Bookdetails._({this.roomType,this.noOfBeds,this.charges});

  factory Bookdetails.fromJson(dynamic json){
    return Bookdetails._(
      roomType: json['roomType'] as String,
      noOfBeds: json['noOfBeds'] as String,
      charges: json['charges'] as String,

    );
  }
}
