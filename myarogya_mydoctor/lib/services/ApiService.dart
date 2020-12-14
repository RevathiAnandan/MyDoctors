


import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
class ApiService{

  bool trigger;
  int no=0;
  List <String> splValues=List();

  int addpres(){
    no++;
    return no;
  }
  FirebaseDatabase fb = FirebaseDatabase.instance;
  Future createUser(String id,String mobile,String category) async{
    print(id);
    try {
      if(category == "Doctor"){
        return fb.reference().child('User').child(mobile)
            .set({
          'id': id,
          'mobile': mobile,
          'category': category,
          //'myPatient': "mypatient"
        });
      }else{
        return fb.reference().child('User').child(mobile)
            .set({
          'id': id,
          'mobile': mobile,
          'category': category,
          //'myDoctor': "mydoctor"
        });
      }
    } catch (e) {
      print(e);
    }

  }

  Future addPatientToDoctor(String pmobile,dmobile,pname) async{

    try {
      var db = fb.reference().child('User').child(dmobile).child("myPatient").push();
      db.set({
        "phone": pmobile,
        "name": pname
      }
      );

    } catch (e) {
      print(e);
    }

  }
  Future addPrecription(String pmobile,String dmobile,String pname,List medicine,String lab,String diagnosis,String bp,String weight,String pulse,String nextVisit,String totaldate,String BPHigh) async{
    try {
      return fb.reference().child("Prescription").child(pmobile).push()
          .set({
        "patientMobile":pmobile,
        "patientName":pname,
        "doctorMobile":dmobile,
        "diagnosis":diagnosis,
        "details": medicine,
        "bp":bp,
        "bpHigh":BPHigh,
        "weight":weight,
        "pulse":pulse,
        "nextVisit":nextVisit,
        "labTest": lab,
        "date":totaldate
      }
      );
    } catch (e) {
      print(e);
    }
  }
  Future addDoctorToPatient(String pmobile,dmobile,dname) async{
    try {
      var db = fb.reference().child('User').child(pmobile).child("myDoctor").push();
      db.set({
        "phone": dmobile,
        "name": dname
      }
      );
    } catch (e) {
      print(e);
    }
  }

  getUsers(String id,String mobile,String category) {
    print(id);
    FirebaseDatabase fb = FirebaseDatabase.instance;
    try {
      var db = fb.reference().child("User").child(mobile).child("image");
      db.once().then((DataSnapshot snapshot){
        print (snapshot.value);
        return snapshot.value;
//      print (db);
      });
    } catch (e) {
      print(e);
    }
  }

  getUserDetails(String mobile){
    FirebaseDatabase fb = FirebaseDatabase.instance;
    try {
      var db = fb.reference().child("User").child(mobile);
      db.once().then((DataSnapshot snapshot){
        print (snapshot.value);
        return snapshot.value;
//      print (db);

      });

    } catch (e) {
      print(e);
    }

  }


  Future updateProfile(
      String id,
      String mobile,
      String category,
      String downloadUrl,
      String doctorId,
      String hospitalName,
      String specialist,
      String degree,
      String dName,
      String email,
      String qrdata,
      String address,
      String starttym,
      String endtym,
      String interval,
      String mstarttym,
      String mendtym,
      String estarttym,
      String eendtymm,
      String sstarttym,
      String sendtym) async{
    print(id);
    try {
      return fb.reference().child('User').child(mobile)
          .update({
        'id': id,
        'mobile': mobile,
        'category': category,
        "image": downloadUrl,
        "registerId": doctorId,
        "hospitalName": hospitalName,
        "Hospital Address": address,
        "specialist": specialist,
        "degree": degree,
        "Start Time":starttym,
        "End Time":endtym,
        "Consulting Interval":interval,
        "Name": dName,
        "emailId": email,
        "QrCode" : qrdata,
        "Morning Start Time":mstarttym,
        "Morning End Time":mendtym,
        "Evening Start Time":estarttym,
        "Evening End Time":eendtymm,
        "Sunday Start Time":sstarttym,
        "Sunday End Time":sendtym
      });

    } catch (e) {
      print(e);
    }

  }

  Future updatePatientProfile(String id,String mobile,String category,String downloadUrl,String pName,String email,String Age) async{
    print(id);
    try {
      return fb.reference().child('User').child(mobile)
          .update({
        'id': id,
        'category': category,
        'mobile':mobile,
        "image": downloadUrl,
        "Name": pName,
        "Age":Age,
        "emailId": email
      });

    } catch (e) {
      print(e);
    }
  }
  
  Future appointment(String pmobile,String dmobile,String pname,String status,int token,String bookingTime,String key,String index) async{

    try{
      final now = new DateTime.now();
      String formatter = DateFormat('yMd').format(now);// 28/03/2020
      if(status == "View"){
        var db = fb.reference().child("Appointment").child(key);
        db.update({
          "doctorMobile":dmobile,
          "patientMobile":pmobile,
          "doctorName":pname,
          "status": status,
          "date": formatter,
          "Token": token,
          "BookingTime":bookingTime,
          "Index": index
        });
        return status;
      }else{
        var db = fb.reference().child("Appointment").push();
        db.set({
          "doctorMobile":dmobile,
          "patientMobile":pmobile,
          "doctorName":pname,
          "status": status,
          "date": formatter,
          "Token": token,
          "BookingTime":bookingTime,
          "Index": index
        });
        return status;
      }
    }catch(e){
      print(e);
    }
  }

  Future bookhospital(String bookingno, String hospitalName,String userno,String status,List bookdetails,String key,String bkdate,String disdate,String canceldate){
    try {
      if (status=="Booking Confirm") {
        var db = fb.reference().child("HospitalBookings").child(key);
        db.update({
                'Status':status,
                "BookingDate":bkdate,
              });
      }else if(status=="Discharge"){
        var db = fb.reference().child("HospitalBookings").child(key);
        db.update({
            'DischargeDate':disdate,
            "Status":status,
        });
      }else if(status=="Cancel"){
        var db = fb.reference().child("HospitalBookings").child(key);
        db.update({
          'CancelDate':canceldate,
          "Status":status,
        });
      }
      else {
        var db = fb.reference().child("HospitalBookings").push();
        db.set({
          "Booking details": bookdetails,
          'BookingNumber':bookingno,
          'UserNumber':userno,
          'Status':status,
          'BookingDate':bkdate,
          'DischargeDate':disdate,
          "Hospital Name": hospitalName,
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future hospitals(String name,String regno,String address,String dateof,String adminname, String pricerange,
      String adminph,
      List accred, String ambulance, String emergency, String bookph, String Opdbk, List images ,String status,
      List freebeds,List conbeds,List coivdbeds ,List beds, List diagnosis, List health,List surgery,
      List special, List facility, List docList, List nurseList, List staffList, List TPA
      ,String is24,String isCovid,String isnabh,String award,String key){
    try {
      if (key == "") {
        var db = fb.reference().child("Hospitals").push();
        db.set({
          'hospitalId': regno,
          'hospitalName': name,
          'address': address,
          'Date of Incorporation': dateof,
          'Administration Name':adminname,
          'Administration Ph no':adminph,
          'accredition' : accred,
          'Price Range': pricerange,
          'Ambulance': ambulance,
          'Emergency':emergency,
          'Booking Ph':bookph,
          'OPD Booking':Opdbk,
          'Images':images,
          'Status':status,
          'Free Bed Details':freebeds,
          'Covid Bed Details':coivdbeds,
          'Concessional Bed Details':conbeds,
          'Special Bed Details':beds,
          'Diagnosis Details':diagnosis,
          'Health Package':health,
          'Surgery Packages':surgery,
          'Speciality':special,
          'Facilities':facility,
          'Doctors':docList,
          'Nurses':nurseList,
          'Staff':staffList,
          'TPA':TPA,
          'Availabilty':is24,
          'Covid':isCovid,
          'NABH':isnabh,
          'Award':award
          //      'rating': hospitals.rating,
          //      'pricerange': hospitals.pricerange,
          //      'prepayment': hospitals.prepayment,
          //      'type': hospitals.type,

          //      'yearsofservice': hospitals.yearsofservice,
          //      'freeBeds': hospitals.bedcatogory,
          //      "rmoname": hospitals.rmoname,
          //      "rmoemergencyNo" : hospitals.rmoemergencyNo,
          //      'date': hospitals.incorporationdate,
          //      'MedicalSocialWorker':hospitals.MedicalSocialWorker,
          //todo: change parameters
        });
      } else {
        var db = fb.reference().child("Hospitals").child(key);
        db.update({
          'hospitalId': regno,
          'hospitalName': name,
          'address': address,
          'Date of Incorporation': dateof,
          'Administration Name':adminname,
          'Administration Ph no':adminph,
          'accredition' : accred,
          'Price Range': pricerange,
          'Ambulance': ambulance,
          'Emergency':emergency,
          'Booking Ph':bookph,
          'OPD Booking':Opdbk,
          'Images':images,
          'Status':status,
          'Free Bed Details':freebeds,
          'Covid Bed Details':coivdbeds,
          'Concessional Bed Details':conbeds,
          'Special Bed Details':beds,
          'Diagnosis Details':diagnosis,
          'Health Package':health,
          'Surgery Packages':surgery,
          'Speciality':special,
          'Facilities':facility,
          'Doctors':docList,
          'Nurses':nurseList,
          'Staff':staffList,
          'TPA':TPA,
          'Availabilty':is24,
          'Covid':isCovid,
          'NABH':isnabh,
          'Award':award
          //      'rating': hospitals.rating,
          //      'pricerange': hospitals.pricerange,
          //      'prepayment': hospitals.prepayment,
          //      'type': hospitals.type,

          //      'yearsofservice': hospitals.yearsofservice,
          //      'freeBeds': hospitals.bedcatogory,
          //      "rmoname": hospitals.rmoname,
          //      "rmoemergencyNo" : hospitals.rmoemergencyNo,
          //      'date': hospitals.incorporationdate,
          //      'MedicalSocialWorker':hospitals.MedicalSocialWorker,
          //todo: change parameters
        });
      }
    } catch (e) {
      print(e);
    }
  }

}