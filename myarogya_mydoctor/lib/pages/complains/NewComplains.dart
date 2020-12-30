import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


  int complainnumber;
  String video;
  String image;
  String doc;
  String _filePath;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController sentoController = TextEditingController();
  final TextEditingController departController = TextEditingController();
  final TextEditingController cnameController = TextEditingController();
  final TextEditingController gvtController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String _chosenValue1 = "Water";
  File _image;
  File _video;
  final picker = ImagePicker();
  Random rand = Random();
  bool isLoading = false;
  bool mediauploaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    complainnumber = rand.nextInt(100000);
  }

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
                  if (_formKey.currentState.validate()&&mediauploaded) {
                    _formKey.currentState.save();
                    AuthService().toast("Your complaint is under process");
                    Navigator.pop(context);
                    ApiService().MyComplains(
                        complainnumber.toString(),
                        aboutController.text,
                        locationController.text,
                        "+91${sentoController.text}",
                        departController.text,
                        cnameController.text,
                        gvtController.text,
                        _chosenValue1,
                        image,
                        video,
                        widget.mobile,0,0,0,0);
                  }else{
                    AuthService().toast("Please Complete filling data and upload media");
                  }

                },
              ),
            ),
          ],
          title: Text("Raise Complain",
              style: TextStyle(
                  color: Colors.redAccent, fontFamily: "Lato", fontSize: 20)),
        ),

        body: isLoading?loadingprogess():SingleChildScrollView(
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: locationController,
                      decoration: new InputDecoration(
                          hintText: "Location"
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                      controller: sentoController,
                      decoration: new InputDecoration(
                          hintText: "Send To (Phone Number)"
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    TextFormField(
                      controller: departController,
                      decoration: new InputDecoration(
                          hintText: "Govt Department"
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // TextFormField(
                    //   controller: gvtController,
                    //   decoration: new InputDecoration(
                    //       hintText: "Govt Authority"
                    //   ),
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontFamily: 'Lato',
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 15,
                    // ),
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
                                      child: Text("Pick Photo",style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: 'Lato',
                                      ),),
                                      onPressed: () {
                                        openImages();
                                        Navigator.pop(context);
                                      }),
                                  DialogButton(
                                      child: Text("Pick Video",style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: 'Lato',
                                      ),),
                                      onPressed: () {
                                        openVideos();
                                        Navigator.pop(context);
                                      }),DialogButton(
                                      child: Center(
                                        child: Text("Pick Document",style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                        ),),
                                      ),
                                      onPressed: () {
                                        opendoc();
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
                      :(_filePath != null)?Center(child: Text(_filePath)):Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "For 18+ viewers",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:MaterialButton(
                        color: Colors.redAccent,
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: (){

                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:MaterialButton(
                        color: Colors.redAccent,
                        child: Text(
                          "No",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: (){

                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
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
                      Text("    Image should be max of 1MB",style: TextStyle(
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
        print("File path: " + _image.path.split('/').last);
        uploadtask(_image,"image");
      } else {
        print('No image selected.');
      }
    });
  }

  openVideos() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera,maxDuration: Duration(seconds: 10));
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

   opendoc() async {
    try {
      File filePath = await FilePicker.getFile(type: FileType.custom,allowedExtensions:['pdf', 'doc'] );
      if (filePath.path == '') {
        return;
      }
      print("File path: " + filePath.path.split('/').last);
      setState((){this._filePath = filePath.path;});
      uploadtask(filePath,"doc");
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
    //todo:if by chance this server crashes and user exeeds the level we can increse this random number until then good bye
    String fileName = "media${rand.nextInt(100000)}";
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("MyComplains")
        .child(complainnumber.toString())
        .child(fileName);
    StorageUploadTask uploadTask = reference.putFile(media);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print("Uploading image completed");
    setState(() {
      isLoading = false;
      mediauploaded = true;
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
