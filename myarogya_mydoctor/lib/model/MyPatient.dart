class MyPatient{
  String phone;
  String name;

  MyPatient._({this.phone, this.name});

  factory MyPatient.fromJson(dynamic json) {

    return new MyPatient._(
      phone: json['phone'] as String,
      name: json['name'] as String
    );
  }
}
