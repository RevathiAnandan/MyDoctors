import 'package:firebase_database/firebase_database.dart';

class ChatModel {
  final String patientMobile;
  final String pid;
  final String pname;


//  final String pimage;

  ChatModel._({this.patientMobile, this.pid, this.pname});
  factory ChatModel.fromJson(dynamic json) {

    return new ChatModel._(
        patientMobile: json['patientMobile'] as String,
        pid: json['pid'] as String,
        pname: json['pname'] as String
    );
  }
}

//class ChatModel {
//  final String patientMobile;
//  final String pid;
//  final String pname;
//
//  ChatModel({
//    this.patientMobile,
//    this.pid,
//    this.pname,
//  });
//
//  ChatModel.fromSnapshot(DataSnapshot snapshot) :
//        patientMobile = snapshot.value["patientMobile"],
//        pid = snapshot.value["pid"],
//        pname = snapshot.value["pname"];
//
//  toJson() {
//    return {
//      "patientMobile": patientMobile,
//      "pid": pid,
//      "pname": pname,
//    };
//  }
//}

//List<ChatModel> dummyData = [
//  new ChatModel(
//      name: "Dr.Pawan Kumar",
//      message: "Hey Flutter, You are so amazing !",
//      time: "15:30",
//      avatarUrl:
//          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
//  new ChatModel(
//      name: "Dr.Harvey Spectre",
//      message: "Hey I have hacked whatsapp!",
//      time: "17:30",
//      avatarUrl:
//          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
//  new ChatModel(
//      name: "Dr.Mike Ross",
//      message: "Wassup !",
//      time: "5:00",
//      avatarUrl:
//          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
//  new ChatModel(
//      name: "Dr.Rachel",
//      message: "I'm good!",
//      time: "10:30",
//      avatarUrl:
//          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
//  new ChatModel(
//      name: "Dr.Barry Allen",
//      message: "I'm the fastest man alive!",
//      time: "12:30",
//      avatarUrl:
//          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
//  new ChatModel(
//      name: "Dr.Joe West",
//      message: "Hey Flutter, You are so cool !",
//      time: "15:30",
//      avatarUrl:
//          "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
//];
