class Patient{
  String phone;
  String name;

  Patient._({this.phone, this.name});

  factory Patient.fromJson(dynamic json) {

    return new Patient._(
      phone: json['phone'] as String,
      name: json['name'] as String,
    );
  }
}
