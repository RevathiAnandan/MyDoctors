import 'dart:core';

class Hospitals{

  String about;
  String hospitalregno;
  String hospitalName;
  String address;
  String incorporationdate;
  String rating;
  String pricerange;
  String prepayment;
  String type;
  String accredition;
  String yearsofservice;
  List<BedCatogory> bedcatogory;
  String rmoname;
  String rmoemergencyNo;
  String area;
  List<MedicalSocialWorkers> MedicalSocialWorker;
  List<Facilities> facilities;
  List<Specialities> specialities;



  Hospitals._({
      this.hospitalregno,
      this.hospitalName,
      this.address,
      this.rating,
      this.pricerange,
      this.prepayment,
      this.type,
      this.accredition,
      this.yearsofservice,
      this.bedcatogory,
      this.rmoname,
      this.rmoemergencyNo,
      this.MedicalSocialWorker,
      this.incorporationdate,
    this.facilities,
    this.specialities,
    this.area,
    this.about
  });

  factory Hospitals.fromJson(dynamic json){
    var medicalsocialworkers = json["MedicalSocialWorkers"] as List;
    List<MedicalSocialWorkers> _MSW = medicalsocialworkers.map((tagJson) => MedicalSocialWorkers.fromJson(tagJson)).toList();
    var speciality = json["Specialities"] as List;
    List<Specialities> _SPL = speciality.map((tagJson) => Specialities.fromJson(tagJson)).toList();
    var facility = json["Facilities"] as List;
    List<Facilities> _FCL = facility.map((tagJson) => Facilities.fromJson(tagJson)).toList();

    return new Hospitals._(
        hospitalregno: json['hospitalregno'] as String,
        hospitalName: json['hospitalName'] as String,
        address: json['address'] as String,
        incorporationdate: json['incorporationdate'] as String,
        rating: json['rating'] as String,
        specialities: _SPL,
        facilities: _FCL,
        pricerange: json['pricerange'] as String,
        prepayment: json['prepayment'] as String,
        type: json['type'] as String,
        accredition: json['accredition'] as String,
        yearsofservice: json['yearsofservice'] as String,

        rmoname: json["rmoname"] as String,
        rmoemergencyNo: json["rmoemergencyNo"] as String,
        MedicalSocialWorker: _MSW,

    );
  }


}

class BedCatogory {

}

class Specialities {
  String spl;

  Specialities._({this.spl});

  factory Specialities.fromJson(dynamic json){
    return Specialities._(
      spl: json['speciality'] as String,
    );
  }

}

class Facilities {
  String fcl;

  Facilities._({this.fcl});

  factory Facilities.fromJson(dynamic json){
    return Facilities._(
      fcl: json['facilitiy'] as String,
    );
  }
}


class MedicalSocialWorkers {
  String name;
  String number;
  MedicalSocialWorkers._({this.name, this.number});

  factory MedicalSocialWorkers.fromJson(dynamic json){
    return MedicalSocialWorkers._(
      name: json["name"] as String,
      number: json["number"] as String,
    );
  }


}