import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarogya_mydoctor/pages/Ads/showvideo.dart';

class Addads extends StatefulWidget {
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
  final picker = ImagePicker();
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
                      controller: nameController,
                      decoration: new InputDecoration(
                        hintText: "Name"
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
                      controller: categoryController,
                      decoration: new InputDecoration(
                          hintText: "Product Category"
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
                      controller: sloganController,
                      decoration: new InputDecoration(
                          hintText: "Slogan"
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
                      child: RaisedButton(
                        child: Text(
                          "Pick Video",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          openVideos();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: (_video!=null)?Stack(
                    children: <Widget>[
                      ShowVideoPlayer(_video),
                    ],
                  ):Container(),
                ),
                Container(
                  height: 200,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        child: Text(
                          "Pick Image",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          openImages();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: (_image!=null)?Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.file(
                        _image,
                        fit: BoxFit.fill,
                      )
                  ):Container(),
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
         print(_video.path);
       } else {
         print('No video selected.');
       }
     });
   }
}
