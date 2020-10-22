

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
class ApiService{

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
          'myPatient': "mypatient"
        });
      }else{
        return fb.reference().child('User').child(mobile)
            .set({
          'id': id,
          'mobile': mobile,
          'category': category,
          'myDoctor': "mydoctor"
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
  Future addPrecription(String pmobile,String dmobile,String pname,List medicine,List lab,String diagnosis,String bp,String weight,String pulse,String nextVisit,String totaldate) async{

    try {
      return fb.reference().child("Prescription").child(pmobile).push()
          .set({
        "patientMobile":pmobile,
        "patientName":pname,
        "doctorMobile":dmobile,
        "diagnosis":diagnosis,
        "details": medicine,
        "bp":bp,
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
      String hours,
      String interval) async{
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
        "Consulting Hours":hours,
        "Consulting Interval":interval,
        "Name": dName,
        "emailId": email,
        "QrCode" : qrdata
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
  
  Future appointment(String pmobile,String dmobile,String pname,String status) async{
    try{
      final now = new DateTime.now();
      String formatter = DateFormat('yMd').format(now);// 28/03/2020
      var db = fb.reference().child("Appointment").push();
      db.set({
        "doctorMobile":dmobile,
        "patientMobile":pmobile,
        "patientName":pname,
        "status": status,
        "date": formatter
      });
      return status;
    }catch(e){
      print(e);
    }
  }
  
  
}