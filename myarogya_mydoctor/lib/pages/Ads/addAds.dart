import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarogya_mydoctor/pages/Ads/showvideo.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';

class Addads extends StatefulWidget {
  final String id;
  final String mobile;

  Addads(this.id, this.mobile);
  @override
  _AddadsState createState() => _AddadsState();
}

class _AddadsState extends State<Addads> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController sloganController = TextEditingController();
  File _image;
  File _video;
  List<File> _media = [];
  String image;
  String video;
  final picker = ImagePicker();
  bool name = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.cloud_upload,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                  } else {
                    AuthService().toast(
                        "Please Complete filling data and Submit down below");
                  }
                  ApiService().MyAds(
                      nameController.text,
                      categoryController.text,
                      sloganController.text,
                      image,
                      video,
                      widget.mobile);
                },
              ),
            ),
          ],
          title: Text("Upload Ads",
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (_) {
                        setState(() {
                          name = true;
                        });
                        print(nameController.text);
                      },
                      controller: nameController,
                      decoration: new InputDecoration(hintText: "Name"),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: categoryController,
                      decoration:
                          new InputDecoration(hintText: "Product Category"),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: sloganController,
                      decoration: new InputDecoration(hintText: "Slogan"),
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "List of my Ads",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "5",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        color: Colors.redAccent,
                        child: Text(
                          "Pick Video",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            openVideos();
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
                      : Container(),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                          color: Colors.redAccent,
                          child: Text(
                            "Pick Image",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              openImages();
                            } else {
                              AuthService()
                                  .toast("Please type the name above ");
                            }
                          }),
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: (_image != null)
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
                      Text(
                        "Note",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.redAccent,
                          fontFamily: 'Lato',
                        ),
                      ),
                      Text(
                        "    Video should be maximum of 10 seconds",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.redAccent,
                          fontFamily: 'Lato',
                        ),
                      ),
                      Text(
                        "    Image should be max of 2MB",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.redAccent,
                          fontFamily: 'Lato',
                        ),
                      ),
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
        _media.add(_image);
        print(_media);
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
        print(_video.path.split(".")[1]);
        _media.add(_video);
        uploadtask(_video,"video");
      } else {
        print('No video selected.');
      }
    });
  }

  Random rand = Random();
  uploadtask(File media,String type) async {
    print("enter uploadtask");
    //todo:if by chance this server crashes and user exeeds the level we can increse this random number until then good bye
    String fileName = "media${rand.nextInt(100000)}";
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("MyAds")
        .child(nameController.text)
        .child(fileName);
    StorageUploadTask uploadTask = reference.putFile(media);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print("Uploading image completed");
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    if (type == "video") {
      video = downloadUrl;
    } else if (type == "image") {
      image = downloadUrl;
    }
  }
}
