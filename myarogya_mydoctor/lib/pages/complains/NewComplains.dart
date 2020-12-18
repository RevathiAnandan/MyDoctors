import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../improvement/dropdownlists.dart';
import '../Ads/showvideo.dart';
class NewComplains extends StatefulWidget {
  final String id;
  final String mobile;
  NewComplains(this.id, this.mobile);
  @override
  _NewComplainsState createState() => _NewComplainsState();
}

class _NewComplainsState extends State<NewComplains> {
  String video;
  String image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController sentoController = TextEditingController();
  final TextEditingController departController = TextEditingController();
  final TextEditingController cnameController = TextEditingController();
  final TextEditingController gvtController = TextEditingController();
  String _chosenValue1 = "Water";
  File _image;
  File _video;
  final picker = ImagePicker();
  Random rand = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            Center(
              child: IconButton(
                icon: Icon(Icons.cloud_upload,color: Colors.redAccent,),
                onPressed: (){
                  ApiService().MyComplains(
                      rand.nextInt(100000).toString(),
                      aboutController.text,
                      sentoController.text,
                      departController.text,
                      cnameController.text,
                      gvtController.text,
                      _chosenValue1,
                      image,
                      video,
                      widget.mobile);
                },
              ),
            ),
          ],
          title: Text("Raise Complains",
              style: TextStyle(
                  color: Colors.redAccent, fontFamily: "Lato", fontSize: 20)),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: aboutController,
                      decoration: new InputDecoration(
                          hintText: "Complain About"
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: sentoController,
                      decoration: new InputDecoration(
                          hintText: "Send To"
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Category",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      value: _chosenValue1,
                      // underline: SizedBox(),
                      items: Dropdownlists().categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue1 = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: departController,
                      decoration: new InputDecoration(
                          hintText: "Department"
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: cnameController,
                      decoration: new InputDecoration(
                          hintText: "Company Name"
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: gvtController,
                      decoration: new InputDecoration(
                          hintText: "Govt Authority"
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text(
                //         "List of my Complains",
                //         style: TextStyle(
                //             color: Colors.redAccent,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Align(
                //       alignment: Alignment.centerRight,
                //       child: Text(
                //         "5",
                //         style: TextStyle(
                //             color: Colors.redAccent,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //
                //   ],
                // ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        color: Colors.redAccent,
                        child: Text(
                          "Upload Media",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Alert(
                                context: context,
                                title: "Choose Type",
                                buttons: [
                                  DialogButton(
                                      child: Text("Pick Images"),
                                      onPressed: () {
                                        openImages();
                                        Navigator.pop(context);
                                      }),
                                  DialogButton(
                                      child: Text("Pick Video"),
                                      onPressed: () {
                                        openVideos();
                                        Navigator.pop(context);
                                      }),
                                ]).show();
                          } else {
                            AuthService().toast("Please type the name above ");
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: (_video != null)
                      ? Stack(
                    children: <Widget>[
                      ShowVideoPlayer(_video),
                    ],
                  )
                      : (_image != null)
                      ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(
                      _image,
                      fit: BoxFit.contain,
                    ),
                  )
                      : Container(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Note",style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontFamily: 'Lato',
                      ),),
                      Text("    Video should be maximum of 10 seconds",style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontFamily: 'Lato',
                      ),),
                      Text("    Image should be max of 2MB",style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontFamily: 'Lato',
                      ),),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ));
  }
  openImages() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadtask(_image,"image");
      } else {
        print('No image selected.');
      }
    });
  }

  openVideos() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
        uploadtask(_video,"video");
        print(_video.path);

      } else {
        print('No video selected.');
      }
    });
  }

  uploadtask(File media,String type) async {
    print("enter uploadtask");
    // await FirebaseAuth.instance.signInAnonymously();
    //todo:if by chance this server crashes and user exeeds the level we can increse this random number until then good bye
    String fileName = "media${rand.nextInt(100000)}";
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("MyComplains")
        .child(aboutController.text)
        .child(fileName);
    StorageUploadTask uploadTask = reference.putFile(media);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print("Uploading image completed");
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    if (type == "video") {
      video = downloadUrl;
      image = "";
    } else if (type == "image") {
      image = downloadUrl;
      video = "";
    }
  }

}
