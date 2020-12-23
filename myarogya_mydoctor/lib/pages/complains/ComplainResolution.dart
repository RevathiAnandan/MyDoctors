import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarogya_mydoctor/model/complains.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class ComplainResolution extends StatefulWidget {
  final String id;
  final String mobile;

  ComplainResolution(this.id, this.mobile);
  @override
  _ComplainResolutionState createState() => _ComplainResolutionState();
}

class _ComplainResolutionState extends State<ComplainResolution> {
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController filename = new TextEditingController();
  List<Complains> complain = [];
  FirebaseDatabase fb = FirebaseDatabase.instance;
  String video;
  String image;
  String doc;
  String _filePath;
  File _image;
  File _video;
  final picker = ImagePicker();
  Random rand = Random();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComplains();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        title: Text("My Complain Resolution",
            style: TextStyle(
                color: Colors.redAccent, fontFamily: "Lato", fontSize: 20)),
      ),
      body: isLoading?loadingprogess():Container(
        height: MediaQuery.of(context).size.height,
        child: Card(
          child:
          // widget.complain.length >0?
          ListView.builder(
            itemCount:complain.length,
            itemBuilder:(context,index){
              return ListTile(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                // title: Text(dummyData[index].userNumber),
                title:Text("Complain Number:"+complain[index].ComplainNumber),
                trailing: Container(
                  width: 200  ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: Text("Reply",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Lato",
                                fontSize: 14)),
                        textColor: Colors.white,
                        onPressed: (){
                          _openPopup(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(25.0),
                            side: BorderSide(
                                color: Colors.redAccent)),
                        padding: EdgeInsets.all(10),
                        color: Colors.redAccent,
                      ),

                    ],
                  ),
                ),
              );
            },
          )
              // :Center(child: Text("No Data Found!!")),
        ),
      ),
    );
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Reply",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              controller: name,
              maxLines: 8,
            ),
            Row(
              children: [
                DialogButton(
                  onPressed: (){
                    openImages();
                  },
                  child: Text("Pick images",
                      style: TextStyle(color: Colors.white)),
                ),
                DialogButton(
                  onPressed: (){
                    openVideos();

                  },
                  child: Text("Pick Video",
                      style: TextStyle(color: Colors.white)),
                ),
                DialogButton(
                  onPressed: (){
                    opendoc();
                  },
                  child: Text("Pick File",
                      style: TextStyle(color: Colors.white)),
                ),

              ],
            ),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'filename',
                border: OutlineInputBorder(),
              ),
              controller: filename,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: (){

            },
            child: Text(
              "Send",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
  openImages() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        _image = File(pickedFile.path);
        print("File path: " + _image.path.split('/').last);
        filename.text=_image.path.split('/').last;
        // uploadtask(_image,"image");
      } else {
        print('No image selected.');
      }
    });
  }
  Future<Complains> getComplains() async{
    await fb.reference().child("MyComplains").once().then((DataSnapshot snapshot) {
      print(snapshot);
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Complains.fromJson(values);
          if(refreshToken.SendTo==widget.mobile)
          complain.add(refreshToken);
          setState(() {
            isLoading =false;
          });
        });
        print(isLoading.toString());
      }
    });
  }

  openVideos() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
        filename.text=_video.path.split('/').last;
        // uploadtask(_video,"video");
        print(_video.path);

      } else {
        print('No video selected.');
      }
    });
  }

  opendoc() async {
    try {
      File filePath = await FilePicker.getFile(type: FileType.custom,allowedExtensions:['pdf', 'doc'] );
      if (filePath.path == '') {
        return;
      }
      print("File path: " + filePath.path.split('/').last);
      setState((){this._filePath = filePath.path;
      filename.text=filePath.path.split('/').last;
      });
      // uploadtask(filePath,"doc");
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  uploadtask(File media,String type) async {
    print("enter uploadtask");
    setState(() {
      isLoading = true;
    });
    // await FirebaseAuth.instance.signInAnonymously();
    //todo:if by chance this server crashes and user exceeds the level we can increase this random number until then good bye
    String fileName = "media${rand.nextInt(100000)}";
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("MyComplains")
        .child("jhnjad")
        .child(fileName);
    StorageUploadTask uploadTask = reference.putFile(media);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print("Uploading image completed");
    setState(() {
      isLoading = false;
    });
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    if (type == "video") {
      video = downloadUrl;
      image = "";
    } else if (type == "image") {
      image = downloadUrl;
      video = "";
    }else if(type == "doc"){
      doc = downloadUrl;
      video = "";
      image = "";
    }
  }
  Widget loadingprogess(){
    return Column(
      children: [
        LinearProgressIndicator(),
        Text("Uploading please wait"),
      ],
    );
  }

}
