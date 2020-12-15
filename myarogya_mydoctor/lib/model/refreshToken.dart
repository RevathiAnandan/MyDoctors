class Payment{
  String status;
  String message;
  String cftoken;

  Payment._({this.status, this.message,this.cftoken});

  factory Payment.fromJson(dynamic json) {

    return new Payment._(
      status: json['status'] as String,
      message: json['message'] as String,
      cftoken: json['cftoken'] as String,
    );
  }
}