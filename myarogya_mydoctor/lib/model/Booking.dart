class Booking{
  String bookingNumber;
  String userNumber;
  String status;


  Booking._({this.bookingNumber, this.userNumber,this.status});

  factory Booking.fromJson(dynamic json) {

    return new Booking._(
      bookingNumber: json['BookingNumber'] as String,
      userNumber: json['UserNumber'] as String,
      status: json['Status'] as String,
    );
  }
}
