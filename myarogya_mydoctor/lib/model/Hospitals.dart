import 'dart:core';

class Hospital{

  String hospitalName;
  String hospitalRegNo;
  String hospitalAddress;
  String dateofIncorporation;
  String adminName;
  String adminPh;
  List<AccredList> accred;
  String pricerange;
  String ambulanceNo;
  String emergencyNo;
  String bookingPhNo;
  String opdBookingNo;
  List image;
  String status;
  String is24;
  String isCovid;
  String isNabh;
  List<FreeBeds> freebeds;
  List<ConBeds> conbeds;
  List<CovidBeds> covidbeds;
  List<OtherBeds> beds;
  List<Diagnosis> diagnosis;
  List<Health> health;
  List<Surgery> surgery;
  List specialities;
  List facilities;
  List<DoctorList> doctorslist;
  List<NursesList> nurseslist;
  List<StaffsList> staffslist;
  List<TpaList> tpalist;


  Hospital._({
      this.hospitalName,
      this.hospitalRegNo,
      this.hospitalAddress,
      this.dateofIncorporation,
      this.adminName,
      this.adminPh,
      this.accred,
      this.pricerange,
      this.ambulanceNo,
      this.emergencyNo,
      this.bookingPhNo,
      this.opdBookingNo,
      this.image,
      this.status,
      this.freebeds,
      this.conbeds,
      this.beds,
      this.covidbeds,
      this.diagnosis,
      this.health,
      this.surgery,
      this.specialities,
      this.facilities,
      this.doctorslist,
      this.nurseslist,
      this.staffslist,
      this.tpalist,
      this.is24,
      this.isCovid,
      this.isNabh
  });

  factory Hospital.fromJson(dynamic json){
    var freebeddetails = json["Free Bed Details"] as List;
    List<FreeBeds> _FREE = freebeddetails.map((tagJson) => FreeBeds.fromJson(tagJson)).toList();
    var conbeddetails = json["Concessional Bed Details"] as List;
    List<ConBeds> _CON = conbeddetails.map((tagJson) => ConBeds.fromJson(tagJson)).toList();
    var coviddetails = json["Covid Bed Details"] as List;
    List<CovidBeds> _COVID = coviddetails.map((tagJson) => CovidBeds.fromJson(tagJson)).toList();
    var splbeddetails = json["Special Bed Details"] as List;
    List<OtherBeds> _BED = splbeddetails.map((tagJson) => OtherBeds.fromJson(tagJson)).toList();
    var diagnosis = json["Diagnosis Details"] as List;
    List<Diagnosis> _DIAGNOSIS = diagnosis.map((tagJson) => Diagnosis.fromJson(tagJson)).toList();
    var health = json["Health Package"] as List;
    List<Health> _HEALTH = health.map((tagJson) => Health.fromJson(tagJson)).toList();
    var surgery = json["Surgery Packages"] as List;
    List<Surgery> _SUR = surgery.map((tagJson) => Surgery.fromJson(tagJson)).toList();
    var doctors = json["Doctors"] as List;
    List<DoctorList> _DOCTOR = doctors.map((tagJson) => DoctorList.fromJson(tagJson)).toList();
    var nurses = json["Nurses"] as List;
    List<NursesList> _NURSE = nurses.map((tagJson) => NursesList.fromJson(tagJson)).toList();
    var staff = json["Staff"] as List;
    List<StaffsList> _STAFF = staff.map((tagJson) => StaffsList.fromJson(tagJson)).toList();
    var tpa = json["TPA"] as List;
    List<TpaList> _TPA = tpa.map((tagJson) => TpaList.fromJson(tagJson)).toList();
    var acred = json["accredition"] as List;
    List<AccredList> _ACCRED = acred.map((tagJson) => AccredList.fromJson(tagJson)).toList();


    return new Hospital._(
        hospitalRegNo: json['hospitalId'] as String,
        hospitalName: json['hospitalName'] as String,
        hospitalAddress: json['address'] as String,
        dateofIncorporation: json['Date of Incorporation'] as String,
        adminName: json['Administration Name'] as String,
        adminPh: json['Administration Ph no'] as String,
        accred: _ACCRED,
        pricerange: json['Price Range'] as String,
        ambulanceNo: json['Ambulance'] as String,
        emergencyNo: json['Emergency'] as String,
        bookingPhNo: json['Booking Ph'] as String,
        opdBookingNo: json['OPD Booking'] as String,
        image: json['Images'] as List,
        status: json['Status'] as String,
        freebeds: _FREE,
        conbeds: _CON,
        beds: _BED,
        covidbeds: _COVID,
        diagnosis: _DIAGNOSIS,
        health: _HEALTH,
        surgery: _SUR,
        specialities: json['Speciality'] as List,
        facilities: json['Facilities'] as List,
        doctorslist: _DOCTOR,
        nurseslist: _NURSE,
        staffslist: _STAFF,
        tpalist: _TPA,
        is24: json['Availabilty'] as String,
        isCovid: json['Covid'] as String,
        isNabh: json['NABH'] as String,
    );
  }


}

class TpaList {
  String insurName;

  TpaList._({this.insurName});

  factory TpaList.fromJson(dynamic json){
    return TpaList._(
      insurName: json['Insurance Name'] as String,
    );
  }
}
class AccredList {
  String accredName;

  AccredList._({this.accredName});

  factory AccredList.fromJson(dynamic json){
    return AccredList._(
      accredName: json['Acredition'] as String,
    );
  }
}

//TODO:Accredition Model Class should be written
class StaffsList {
  String name;
  String phno;

  StaffsList._({this.name, this.phno});

  factory StaffsList.fromJson(dynamic json){
    return StaffsList._(
      name: json['Name'] as String,
      phno: json['PhNumber'] as String,
    );
  }


}

class NursesList {
  String name;
  String phno;

  NursesList._({this.name, this.phno});

  factory NursesList.fromJson(dynamic json){
    return NursesList._(
      name: json['Name'] as String,
      phno: json['PhNumber'] as String,
    );
  }
}

class DoctorList {
  String name;
  String phno;
  DoctorList._({this.name, this.phno});


  factory DoctorList.fromJson(dynamic json){
    return DoctorList._(
      name: json['Name'] as String,
      phno: json['PhNumber'] as String,
    );
  }

}

class Health {
  String packagename;
  String amount;

  Health._({this.packagename, this.amount});

  factory Health.fromJson(dynamic json){
    return Health._(
      packagename: json['Type'] as String,
      amount: json['charges'] as String,
    );
  }
}
class Surgery {
  String surgeryname;
  String suramount;

  Surgery._({this.surgeryname, this.suramount});

  factory Surgery.fromJson(dynamic json){
    return Surgery._(
      surgeryname: json['Type'] as String,
      suramount: json['charges'] as String,
    );
  }
}


class Diagnosis {
  String test;
  String charge;

  Diagnosis._({this.test, this.charge});

  factory Diagnosis.fromJson(dynamic json){
    return Diagnosis._(
      test: json['Type'] as String,
      charge: json['charges'] as String,
    );
  }
}

class ConBeds {
  String roomType;
  String noOfBeds;
  String charges;

  ConBeds._({this.roomType,this.noOfBeds,this.charges});

  factory ConBeds.fromJson(dynamic json){
    return ConBeds._(
      roomType: json['roomType'] as String,
      noOfBeds: json['noOfBeds'] as String,
      charges: json['charges'] as String,

    );
  }
}

class FreeBeds {
  String roomType;
  String noOfBeds;
  String charges;

  FreeBeds._({this.roomType,this.noOfBeds,this.charges});

  factory FreeBeds.fromJson(dynamic json){
    return FreeBeds._(
      roomType: json['roomType'] as String,
      noOfBeds: json['noOfBeds'] as String,
      charges: json['charges'] as String,

    );
  }
}

class CovidBeds{
  String roomType;
  String noOfBeds;
  String charges;

  CovidBeds._({this.roomType,this.noOfBeds,this.charges});

  factory CovidBeds.fromJson(dynamic json){
    return CovidBeds._(
      roomType: json['roomType'] as String,
      noOfBeds: json['noOfBeds'] as String,
      charges: json['charges'] as String,

    );
  }
}


class OtherBeds {
  String roomType;
  String noOfBeds;
  String charges;

  OtherBeds._({this.roomType,this.noOfBeds,this.charges});

  factory OtherBeds.fromJson(dynamic json){
    return OtherBeds._(
      roomType: json['roomType'] as String,
      noOfBeds: json['noOfBeds'] as String,
      charges: json['charges'] as String,

    );
  }
}