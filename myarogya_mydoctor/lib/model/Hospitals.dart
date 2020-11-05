import 'dart:core';

class Hospitals{

  String hospitalId;
  String hospitalName;
  String location;
  String rating;
  String pricerange;
  String prepayment;
  String type;
  String accredition;
  String speciality;
  String yearsofservice;
  String freebeds;
  String concessionalratebeds;
  String unreservedbeds;
  String rmoname;
  String rmoemergencyNo;
  List<MedicalSocialWorkers> MedicalSocialWorker;
  String date;


  Hospitals._({
      this.hospitalId,
      this.hospitalName,
      this.location,
      this.rating,
      this.pricerange,
      this.prepayment,
      this.type,
      this.accredition,
      this.speciality,
      this.yearsofservice,
      this.freebeds,
      this.concessionalratebeds,
      this.unreservedbeds,
      this.rmoname,
      this.rmoemergencyNo,
      this.MedicalSocialWorker,
      this.date});

  factory Hospitals.fromJson(dynamic json){
    var medicalsocialworkers = json["MedicalSocialWorkers"] as List;
    List<MedicalSocialWorkers> _MSW = medicalsocialworkers.map((tagJson) => MedicalSocialWorkers.fromJson(tagJson)).toList();
    return new Hospitals._(
        hospitalId: json['hospitalId'] as String,
        hospitalName: json['hospitalName'] as String,
        location: json['location'] as String,
        rating: json['rating'] as String,
        pricerange: json['pricerange'] as String,
        prepayment: json['prepayment'] as String,
        type: json['type'] as String,
        accredition: json['accredition'] as String,
        speciality: json['speciality'] as String,
        yearsofservice: json['yearsofservice'] as String,
      freebeds: json["freeBeds"] as String,
      concessionalratebeds: json["concessionalratebeds"] as String,
      unreservedbeds: json["unreservedbeds"] as String,
      rmoname: json["rmoname"] as String,
      rmoemergencyNo: json["rmoemergencyNo"] as String,
        MedicalSocialWorker: _MSW,
        date: json['date'] as String,
    );
  }


}

class ROMS {
  String name;
  String emergencyNo;

  ROMS._({this.name, this.emergencyNo});
  factory ROMS.fromJson(dynamic json){
    return new ROMS._(
      name: json["name"] as String,
      emergencyNo: json["emergencyNo"] as String,
    );
  }

}

class Beds {
  String freebeds;
  String concessionalratebeds;
  String unreservedbeds;

  Beds._({this.freebeds, this.concessionalratebeds, this.unreservedbeds});

  factory Beds.fromJson(dynamic json){
    return new Beds._(
      freebeds: json["free beds"] as String,
      concessionalratebeds: json["concessionalratebeds"] as String,
      unreservedbeds: json["unreservedbeds"] as String,
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