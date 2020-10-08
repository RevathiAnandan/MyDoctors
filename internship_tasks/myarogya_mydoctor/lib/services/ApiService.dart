

import 'package:firebase_database/firebase_database.dart';

class ApiService{

  FirebaseDatabase fb = FirebaseDatabase.instance;
  Future createUser(String id,String mobile,String category,String fcmToken) async{
    print(id);
    try {
      return fb.reference().child('User').child(mobile)
          .set({
        'id': id,
        'mobile': mobile,
        'category': category,
        'fcmToken':fcmToken
      });

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


  Future updateProfile(String id,String mobile,String category,String downloadUrl,String doctorId,String hospitalName,String specialist,String degree,String dName,String email) async{
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
        "specialist": specialist,
        "degree": degree,
        "Name": dName,
        "emailId": email
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



}