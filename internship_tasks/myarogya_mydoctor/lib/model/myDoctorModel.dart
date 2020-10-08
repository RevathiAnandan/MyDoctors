class MyDoctorModel {
  final String dname;
  final String doctorMobile;


//  final String pimage;

  MyDoctorModel._({this.dname, this.doctorMobile});
  factory MyDoctorModel.fromJson(dynamic json) {

    return new MyDoctorModel._(
        dname: json['dname'] as String,
        doctorMobile: json['doctorMobile'] as String
    );
  }
}