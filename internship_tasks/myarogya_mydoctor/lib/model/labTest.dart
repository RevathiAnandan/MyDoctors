class LabTest{
  String test;


  LabTest._({this.test});

  factory LabTest.fromJson(dynamic json) {

    return new LabTest._(
      test: json['test'] as String,
    );
  }
}
