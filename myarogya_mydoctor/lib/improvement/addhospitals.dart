import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarogya_mydoctor/improvement/dropdownlists.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_new_dashboard.dart';
import 'package:myarogya_mydoctor/pages/Hospital/HospitalDashboard.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_new_dashboard.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mock_data/mock_data.dart';
import 'package:file_picker/file_picker.dart';

import 'hospitals.dart';

class AddHospital extends StatefulWidget {

  final String mobile;
  final String id;
  final String category;

  AddHospital(this.id,this.mobile,this.category);

  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  TextEditingController _nameController;
  static List<String> doctorsList = [null];
  static List nursesList = [null];
  static List<String> staffsList = [null];
  StorageTaskSnapshot downloadUrl;
  List<String> imagesUrl = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    notecontroller.text = "3 days charges will be paid as Deposit" ;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  List<String> path = [];
  String _path;
  Map<String, String> _paths;
  String _extension;
  FileType _picktype;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  List bytes;
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  bool isUploading = false;
  bool is24 = false;
  bool isCovid = false;
  bool isnabh = false;
  bool uploading = false;
  String popop = mockString(50);
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  openFileExplorer() async {

    try {
      _path = null;
      _paths = await FilePicker.getMultiFilePath(type: FileType.image);
      print(_paths);
      _paths.forEach((filename, filepath) {
        setState(() {
          path.add(filepath);
        });
      });
      if (!mounted) {
        return;
      }
      uploadtoFirebase();
    } on PlatformException catch (e) {
      print("Unsupported Operation" + e.toString());
    }
  }

  uploadtoFirebase() {
    _paths.forEach((filename, filepath) {
      upload(filename, filepath);
    });
  }

  // download()async{
  //   List<Widget> list = new List<Widget>();
  //   _paths.forEach((key, value) { })
  // }
  // showimages(){
  //   List<Widget> list = new List<Widget>();
  //   for(int i=0;i<_tasks.length;i++){
  //     if(bytes[i]!=null) {
  //       list.add(
  //         Image.memory(
  //           bytes[i],
  //           fit: BoxFit.fill,
  //         ),
  //       );
  //     }else{
  //       list.add(
  //         Container(),
  //       );
  //     }
  //   }
  //   return new  Wrap(
  //       spacing: 5.0,
  //       runSpacing: 3.0,
  //       children: _tasks.length==null?Container():list);
  // }
  upload(filename, filepath) async {
    setState(() {
      uploading = true;
    });
    await FirebaseAuth.instance.signInAnonymously();
    _extension = filename.toString().split('.').last;
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("hospitals")
        .child("${nameController.text}/$filename");
    final StorageUploadTask uploadTask = ref.putFile(
        File(filepath),
        StorageMetadata(
          contentType: "$_picktype/$_extension",
        ));
    setState(() {
      _tasks.add(uploadTask);
    });
    StorageTaskSnapshot storageTaskSnapshot;
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    if (snapshot.error == null) {
      storageTaskSnapshot = snapshot;
      final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      imagesUrl.add(downloadUrl);
      print('Upload success');
      setState(() {
        uploading = false;
      });
    } else {
      print('Error from image repo ${snapshot.error.toString()}');
      throw ('This file is not an image');
    }
    print(imagesUrl.length);
    return imagesUrl;
  }
  // Future saveImage(List<Asset> asset) async {
  //   await FirebaseAuth.instance.signInAnonymously();
  //   String fileName = popop;
  //
  //   await Future.wait(asset.map((e) async {
  //     ByteData byteData = await e.getByteData();
  //     List<int> imageData = byteData.buffer.asUint8List();
  //     StorageReference ref = FirebaseStorage.instance.ref().child("hospitals").child("${nameController.text}/$fileName");
  //     StorageUploadTask uploadTask = ref.putData(imageData);
  //     StorageTaskSnapshot storageTaskSnapshot;
  //     StorageTaskSnapshot snapshot = await uploadTask.onComplete;
  //     if (snapshot.error == null) {
  //       storageTaskSnapshot = snapshot;
  //       final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
  //       imagesUrl.add(downloadUrl);
  //       print('Upload success');
  //     } else {
  //       print('Error from image repo ${snapshot.error.toString()}');
  //       throw ('This file is not an image');
  //     }
  //   }), eagerError: true, cleanUp: (_) {
  //     print('eager cleaned up');
  //   });
  //   return imagesUrl;
  //   for(int i=0;i<asset.length;i++){
  //     ByteData byteData = await asset[i].getByteData();
  //     List<int> imageData = byteData.buffer.asUint8List();
  //     StorageReference ref = FirebaseStorage.instance.ref().child("hospitals").child("${nameController.text}/$fileName");
  //     StorageUploadTask uploadTask = ref.putData(imageData);
  //     // downloadUrl = await uploadTask.onComplete;
  //     // String _urls = await downloadUrl.ref.getDownloadURL();
  //     // print("urls"+_urls);
  //     // imagesUrl.add(_urls);
  //     // print(imagesUrl.toString());
  //     // return await uploadTask.onComplete..ref.getDownloadURL();
  //   }
  //   // StorageTaskSnapshot storageTaskSnapshot;
  //   // StorageTaskSnapshot snapshot = await uploadTask.onComplete;
  //   // if (snapshot.error == null) {
  //   //   storageTaskSnapshot = snapshot;
  //   //   final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
  //   //   imagesUrl.add(downloadUrl);
  //   //   print('Upload success');
  //   // } else {
  //   //   print('Error from image repo ${snapshot.error.toString()}');
  //   //   throw ('This file is not an image');
  //   // }
  //   // return imagesUrl;
  //   // ByteData byteData = await asset.getByteData();
  //   // List<int> imageData = byteData.buffer.asUint8List();
  //   // StorageReference ref = FirebaseStorage.instance.ref().child("hospitals/${nameController.text}/$fileName");
  //   // StorageUploadTask uploadTask = ref.putData(imageData);
  //   // downloadUrl = await uploadTask.onComplete..ref.getDownloadURL();
  //   // print(downloadUrl);
  //   // return await uploadTask.onComplete..ref.getDownloadURL();
  // }
  // Future<void> loadAssets() async {
  //   List<Asset> resultList = List<Asset>();
  //   String error = 'No Error Dectected';
  //   try {
  //     resultList = await
  //     MultiImagePicker.pickImages(
  //       maxImages: 300,
  //       enableCamera: true,
  //       selectedAssets: images,
  //       cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
  //       materialOptions: MaterialOptions(
  //         actionBarColor: "#abcdef",
  //         actionBarTitle: "Select Photos",
  //         allViewTitle: "All Photos",
  //         useDetailsView: false,
  //         selectCircleStrokeColor: "#000000",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     error = e.toString();
  //     print(error);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     images = resultList;
  //     _error = error;
  //   });
  // }

  final _formKey = GlobalKey<FormState>();
  List<Widget> specialBeds = [];
  List<Widget> diagnosisCharge = [];
  List<Widget> healthCharges = [];
  List<Widget> TPAInsurance = [];
  List<Widget> Accred = [];
  List Beds = [];
  List freebeds = [];
  List conbeds = [];
  List covidbeds = [];
  List diagnosis = [];
  List health = [];
  List surgery = [];
  List accred = [];
  List insurance = [];
  List docnamenum = [];
  List nursenamenum = [];
  List staffnamenum = [];
  List TPA = [];
  List ACCRED = [];

  List topics = [
    "Hospital Details",
    "Important Numbers",
    "Upload images",
    "Room Tariff",
    "Diagnosis Charges",
    "Health Checkup Packages",
    "Surgery & Other Packages",
    "Speciality",
    "Facility",
    "Insurance",
    "Staff Details",
    "Terms & Conditions",
  ];
  int pageindex = 0;
  String _chosenValue1 = "Aditya Birla Health Insurance Co. Ltd.";
  String _chosenValue2 =
      "NABH- National Accreditation Board for Hospitals and Healthcare Providers";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController regController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateofController = TextEditingController();
  final TextEditingController adminiController = TextEditingController();
  final TextEditingController adminiphoneController = TextEditingController();
  final TextEditingController accredController = TextEditingController();
  final TextEditingController awardsController = TextEditingController();
  final TextEditingController ambuController = TextEditingController();
  final TextEditingController emerController = TextEditingController();
  final TextEditingController bookphController = TextEditingController();
  final TextEditingController opdbkController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController tpaController = TextEditingController();
  final TextEditingController bedsController = TextEditingController();
  final TextEditingController bedsController1 = TextEditingController();
  final TextEditingController bedsController2 = TextEditingController();
  final TextEditingController bedsController3 = TextEditingController();
  final TextEditingController chargesController = TextEditingController();
  final TextEditingController chargesController1 = TextEditingController();
  final TextEditingController chargesController2 = TextEditingController();
  final TextEditingController notecontroller = TextEditingController();
  final TextEditingController chargesController3 = TextEditingController();
  final TextEditingController dchargesController = TextEditingController();
  final TextEditingController nchargesController = TextEditingController();
  final TextEditingController pchargesController = TextEditingController();
  final TextEditingController phchargesController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController opdController = TextEditingController();
  final TextEditingController packController = TextEditingController();
  final TextEditingController surController = TextEditingController();
  final TextEditingController suramtController = TextEditingController();
  final TextEditingController amtController = TextEditingController();
  final TextEditingController roomtype = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController tandccontroller = TextEditingController();

  List<bool> _selected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<bool> facility = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> spl = [];
  List<String> fcl = [];

  List dynamicListD = [];
  List dynamicListN = [];
  List dynamicListS = [];
  List doclist=[];
  List nurlist=[];
  List stafflist=[];
  bool _checked = false;
  bool buttonstatus = true;

  List<String> NumberD = [];

  List<String>Doctor = [];
  List<String>Specialist = [];
  List<String> NumberN = [];

  List<String>Nurse = [];
  List<String> NumberS = [];

  List<String>Staff = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: (pageindex == 0)
                ? IconButton(
              icon: Icon(Icons.close),
              onPressed: () => {
                showAlertDialog(context),
              },
              color: Colors.redAccent,
              iconSize: 30,
            )
                : IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  pageindex--;
                });
              },
              color: Colors.redAccent,
              iconSize: 30,
            ),
            actions: [
              Center(
                child: pageindex == 11
                    ? Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                )
                    : Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              pageindex == 11
                  ? IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  try {
                    print(_formKey.currentState.validate());
                    if (_formKey.currentState.validate()&&_checked) {
                      _formKey.currentState.save();
                      addfreeBeds();
                      ApiService().hospitals(
                                            nameController.text,
                                            regController.text,
                                            addressController.text,
                                            dateofController.text,
                                            adminiController.text,
                                            pincode.text,
                                            adminiphoneController.text,
                                            ACCRED,
                                            "+91${ambuController.text}",
                                            "+91${emerController.text}",
                                            "+91${bookphController.text}",
                                            "+91${opdbkController.text}",
                                            imagesUrl,
                                            "Completed",
                                            freebeds,
                                            conbeds,
                                            covidbeds,
                                            Beds,
                                            notecontroller.text,
                                            diagnosis,
                                            health,
                                            surgery,
                                            spl,
                                            fcl,
                                            doclist,
                                            nurlist,
                                            stafflist,
                                            TPA,
                                            is24.toString(),
                                            isCovid.toString(),
                                            isnabh.toString(),
                                            awardsController.text,
                                            tandccontroller.text,
                                            "",
                                            widget.mobile,
                      );
                      print(tandccontroller.text);
                      AuthService()
                          .toast("Your Added Hospital Is Under Verification");
                      Navigator.pop(context);
                    }
                    else{
                      AuthService().toast("Oops you missed some data, please fill it completely");
                    }
                  } catch (e) {
                    print(e);
                  }

                },
                color: Colors.redAccent,
                iconSize: 30,
              )
                  : IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  // if (pageindex == 3) {

                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        pageindex++;
                      });
                    }
                  // }
                  else if(pageindex == 10){
                    if (_checked) {
                      _formKey.currentState.save();
                      setState(() {
                        pageindex++;
                      });
                    }
                    else{
                      AuthService().toast("Please Complete filling data and Submit down below");
                    }
                  }
                  // else {
                  //   if (1==1) {
                  //     _formKey.currentState.save();
                  //     print("_formkeyValue::"+_formKey.toString());
                  //     setState(() {
                  //       pageindex++;
                  //     });
                  //   }
                  // }
                },
                color: Colors.redAccent,
                iconSize: 30,
              ),
            ],
            backgroundColor: Colors.white,
            title: Text(
              topics[pageindex],
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20.0,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body:
          SingleChildScrollView(child: changingpages(pageindex, context))),
    );
  }

  // ignore: missing_return
  Container changingpages(int pageindex, BuildContext context) {
    switch (pageindex) {
      case 0:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Name"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Registration Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: regController,
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Register Number"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Address",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                  controller: addressController,
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Location"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Date of Incorporation",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.contains("/") && value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                    LengthLimitingTextInputFormatter(10),
                    _DateFormatter(),
                  ],
                  // keyboardType: TextInputType.numberWithOptions(),
                  controller: dateofController,
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                      hintText: "DD/MM/YYYY"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Administrator Name",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: adminiController,
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Name"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Administrator Phone Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  controller: adminiphoneController,
                  decoration: new InputDecoration(
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Name"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Accreditation",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 60,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 42,
                    value: _chosenValue2,
                    // underline: SizedBox(),
                    items: Dropdownlists()
                        .accredlist
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue2 = value;
                        if(_chosenValue2 == Dropdownlists().accredlist[0]){
                          isnabh = true;
                        }
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addaccred,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                Container(
                    child: Center(
                        child: dataBody3("Acredition",ACCRED))
//                  ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: healthCharges.length,
//                      itemBuilder: (_, index) => healthCharges[index]),
                ),
                // Container(
                //   child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: Accred.length,
                //       itemBuilder: (_, index) => Accred[index]),
                // ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Pin code",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    // LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: pincode,
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    //   hintText: ""
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Awards",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: awardsController,
                  decoration: new InputDecoration(
                    // errorBorder: OutlineInputBorder(),
                    // disabledBorder: InputBorder.none,
                    // hintText: "Hospital Name"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          ),
        );
      case 1:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ambulance Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ambuController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Register Number"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Emergency Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: emerController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Location"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Booking Phone Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: bookphController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Name"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "OPD Booking Number",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: opdbkController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
                    // border: OutlineInputBorder(),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    //errorBorder: OutlineInputBorder(),
                    //disabledBorder: InputBorder.none,
                    // hintText: "Hospital Name"
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      case 2:
        setState(() {});
        return uploading?Container(height:MediaQuery.of(context).size.height,child: Center(child: Column(
          children: [
            CircularProgressIndicator(),
            Text("Uploading the photos please wait"),
          ],
        ))):
        Container(
          padding: EdgeInsets.all(20),
          // height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text(
                      "Pick images",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () {
                      openFileExplorer();
                    },
                  ),
                ),
                Container(
                  height: 500,
                  width: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(
                      path.length,
                          (index) {
                        return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.file(
                              File(path[index]),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      case 3:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 110,
                      height: 20,
                    ),
                    Container(
                      width: 110,
                      height: 20,
                      child: Text(
                        "Number of Beds",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 20,
                      child: Text(
                        "Charges Per Day",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 110,
                      height: 40,
                      child: Center(
                        child: Text(
                          "100% Free",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: bedsController,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: chargesController,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 110,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Concessional",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: bedsController1,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: chargesController1,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 110,
                      height: 40,
                      child: Center(
                        child: Text(
                          "COVID Beds",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: bedsController3,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: chargesController3,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 110,
                      height: 40,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                          BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      child: TextFormField(
                        decoration: new InputDecoration(
                          //border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          hintText: "Room Type",
                        ),
                        controller: roomtype,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Lato',
                        ),
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
                      ),

                      // DropdownButton<String>(
                      //   isExpanded: true,
                      //   icon: Icon(Icons.arrow_drop_down),
                      //   iconSize: 42,
                      //   value: _chosenValue1,
                      //   // underline: SizedBox(),
                      //   items: <String>[
                      //     'Economy',
                      //     'Economy Plus',
                      //     'Twin Delux',
                      //     'Delux',
                      //     'Junior-Suite',
                      //     'Grand-Suite'
                      //   ].map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String value) {
                      //     setState(() {
                      //       _chosenValue1 = value;
                      //     });
                      //   },
                      // ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: bedsController2,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
                       // validator: (value) {
                       //   if (value.isEmpty) {
                       //     return 'Please enter some text';
                       //   }
                       //   return null;
                       // },
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'Please enter some text';
                        //   }
                        //   return null;
                        // },
                        controller: chargesController2,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                        ),
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(width: 110,
                        height: 40,child: Center(child: Text("Note:",style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                ),
                      ),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 40,
                      child: TextFormField(
                        // keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          // FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          //errorBorder: OutlineInputBorder(),
                          //disabledBorder: InputBorder.none,
                          // hintText: "Hospital Name"
                        ),
                        controller: notecontroller,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Lato',
                        ),
                       // validator: (value) {
                       //   if (value.isEmpty) {
                       //     return 'Please enter some text';
                       //   }
                       //   return null;
                       // },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addSpecialBeds,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: dataBody(
                        "Room Type", "No of Beds", "Charges per day", Beds)
//                  ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: specialBeds.length,
//                      itemBuilder: (_, index) => specialBeds[index]),
                ),
              ],
            ),
          ),
        );
      case 4:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex:1,
                      child: Container(
                        height: 40,
                        child: Text(
                          "Test Description",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex:1,
                      child: Container(
                        // width: 110,
                        height: 40,
                        child: Text(
                          "Charges",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex:1,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            //errorBorder: OutlineInputBorder(),
                            //disabledBorder: InputBorder.none,
                            // hintText: "Hospital Name"
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          controller: descController,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex:1,
                      child: Container(
                        // width: 180,
                        height: 40,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            //errorBorder: OutlineInputBorder(),
                            //disabledBorder: InputBorder.none,
                            // hintText: "Hospital Name"
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          controller: opdController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            // FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addDiagnosisCharged,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    child: Center(
                        child:
                        dataBody1("Type", "charges", diagnosis))
//                  ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: diagnosisCharge.length,
//                      itemBuilder: (_, index) => diagnosisCharge[index]),
                ),
              ],
            ),
          ),
        );
      case 5:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        child: Text(
                          "Package Name",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        child: Text(
                          "Amount",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            //errorBorder: OutlineInputBorder(),
                            //disabledBorder: InputBorder.none,
                            // hintText: "Hospital Name"
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          controller: packController,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            //errorBorder: OutlineInputBorder(),
                            //disabledBorder: InputBorder.none,
                            // hintText: "Hospital Name"
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          controller: amtController,
                          inputFormatters: <TextInputFormatter>[
                            // FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addHeathCheckup,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    child: Center(
                        child: dataBody1("Type", "charges", health))
//                  ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: healthCharges.length,
//                      itemBuilder: (_, index) => healthCharges[index]),
                ),
              ],
            ),
          ),
        );
      case 6:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        child: Text(
                          "Surgery Name",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        child: Text(
                          "Amount",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            //errorBorder: OutlineInputBorder(),
                            //disabledBorder: InputBorder.none,
                            // hintText: "Hospital Name"
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          controller: surController,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            //errorBorder: OutlineInputBorder(),
                            //disabledBorder: InputBorder.none,
                            // hintText: "Hospital Name"
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          controller: suramtController,
                          inputFormatters: <TextInputFormatter>[
                          //  FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Deposit of 10% is needed"),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addSurgery,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    child: Center(
                        child: dataBody2("Type", "charges", surgery))
//                  ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: healthCharges.length,
//                      itemBuilder: (_, index) => healthCharges[index]),
                ),
              ],
            ),
          ),
        );
      case 7:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Specialities",
                //   style: TextStyle(
                //     color: Colors.redAccent,
                //     fontSize: 18,
                //     fontFamily: 'Lato',
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      // ChoiceChip(
                      //   avatar: _selected[0] ? Icon(Icons.done) : null,
                      //   label: Text("Blood"),
                      //   labelStyle: TextStyle(
                      //       color: Colors.redAccent,
                      //       fontSize: 16.0,
                      //       fontWeight: FontWeight.bold),
                      //   selected: _selected[0],
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(30.0),
                      //   ),
                      //   backgroundColor: Color(0xffededed),
                      //   onSelected: (bool selected) {
                      //     setState(() {
                      //       _selected[0] = !_selected[0];
                      //       spl.contains("Blood")
                      //           ? spl.remove("Blood")
                      //           : spl.add("Blood");
                      //       print(spl.length);
                      //       print(spl.toString());
                      //     });
                      //   },
                      //   selectedColor: Color(0xffededed),
                      // ),
                      ChoiceChip(
                        avatar: _selected[1] ? Icon(Icons.done) : null,
                        label: Text("COVID"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[1],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[1] = !_selected[1];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("COVID")
                                ? spl.remove("COVID")
                                : spl.add("COVID");
                            print(spl.length);
                            isCovid = true;
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[13] ? Icon(Icons.done) : null,
                        label: Text("Cancer"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[13],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[13] = !_selected[13];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Cancer")
                                ? spl.remove("Cancer")
                                : spl.add("Cancer");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[14] ? Icon(Icons.done) : null,
                        label: Text("Cardio"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[1],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[14] = !_selected[14];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Cardio")
                                ? spl.remove("Cardio")
                                : spl.add("Cardio");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[2] ? Icon(Icons.done) : null,
                        label: Text("Child"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[2],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[2] = !_selected[2];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Child")
                                ? spl.remove("Child")
                                : spl.add("Child");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[3] ? Icon(Icons.done) : null,
                        label: Text("Diabetic"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[3],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[3] = !_selected[3];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Diabetic")
                                ? spl.remove("Diabetic")
                                : spl.add("Diabetic");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[4] ? Icon(Icons.done) : null,
                        label: Text("ENT"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[4],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[4] = !_selected[4];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("ENT")
                                ? spl.remove("ENT")
                                : spl.add("ENT");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[5] ? Icon(Icons.done) : null,
                        label: Text("Gastro"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[5],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[5] = !_selected[5];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Gastro")
                                ? spl.remove("Gastro")
                                : spl.add("Gastro");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[6] ? Icon(Icons.done) : null,
                        label: Text("Gynac"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[6],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[6] = !_selected[6];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Gynac")
                                ? spl.remove("Gynac")
                                : spl.add("Gynac");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[0] ? Icon(Icons.done) : null,
                        label: Text("Liver"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[0],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[0] = !_selected[0];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Liver")
                                ? spl.remove("Liver")
                                : spl.add("Liver");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[7] ? Icon(Icons.done) : null,
                        label: Text("Kidney"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[7],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[7] = !_selected[7];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Kidney")
                                ? spl.remove("Kidney")
                                : spl.add("Kidney");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),

                      ChoiceChip(
                        avatar: _selected[8] ? Icon(Icons.done) : null,
                        label: Text("Neuro"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[8],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[8] = !_selected[8];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Neuro")
                                ? spl.remove("Neuro")
                                : spl.add("Neuro");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[9] ? Icon(Icons.done) : null,
                        label: Text("Ortho"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[9],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[9] = !_selected[9];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Ortho")
                                ? spl.remove("Ortho")
                                : spl.add("Ortho");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[10] ? Icon(Icons.done) : null,
                        label: Text("Skin"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[10],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[10] = !_selected[10];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Skin")
                                ? spl.remove("Skin")
                                : spl.add("Skin");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[11] ? Icon(Icons.done) : null,
                        label: Text("Uro"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[11],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[11] = !_selected[11];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Uro")
                                ? spl.remove("Uro")
                                : spl.add("Uro");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: _selected[12] ? Icon(Icons.done) : null,
                        label: Text("Others"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: _selected[12],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            _selected[12] = !_selected[12];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            spl.contains("Others")
                                ? spl.remove("Others")
                                : spl.add("Others");
                            print(spl.length);
                            print(spl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        );
      case 8:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Facilities",
                //   style: TextStyle(
                //     color: Colors.redAccent,
                //     fontSize: 18,
                //     fontFamily: 'Lato',
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    children: <Widget>[
                      ChoiceChip(
                        avatar: facility[0] ? Icon(Icons.done) : null,
                        label: Text("Ambulance"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[0],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[0] = !facility[0];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Ambulance")
                                ? fcl.remove("Ambulance")
                                : fcl.add("Ambulance");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[1] ? Icon(Icons.done) : null,
                        label: Text("ATM"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[1],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[1] = !facility[1];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("ATM")
                                ? fcl.remove("ATM")
                                : fcl.add("ATM");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[2] ? Icon(Icons.done) : null,
                        label: Text("Blood Bank"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[2],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[2] = !facility[2];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Blood Bank")
                                ? fcl.remove("Blood Bank")
                                : fcl.add("Blood Bank");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[3] ? Icon(Icons.done) : null,
                        label: Text("Cafeteria"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[3],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[3] = !facility[3];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Cafeteria")
                                ? fcl.remove("Cafeteria")
                                : fcl.add("Cafeteria");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[4] ? Icon(Icons.done) : null,
                        label: Text("Dental Clinic"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[4],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[4] = !facility[4];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Dental Clinic")
                                ? fcl.remove("Dental Clinic")
                                : fcl.add("Dental Clinic");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[5] ? Icon(Icons.done) : null,
                        label: Text("Doctors availability 24/7"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[5],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[5] = !facility[5];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Doctors availability 24/7")
                                ? fcl.remove("Doctors availability 24/7")
                                : fcl.add("Doctors availability 24/7");
                            is24 = true;
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[20] ? Icon(Icons.done) : null,
                        label: Text("ECG"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[5],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[20] = !facility[20];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("ECG")
                                ? fcl.remove("ECG")
                                : fcl.add("ECG");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[6] ? Icon(Icons.done) : null,
                        label: Text("Gym"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[6],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[6] = !facility[6];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Gym")
                                ? fcl.remove("Gym")
                                : fcl.add("Gym");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[7] ? Icon(Icons.done) : null,
                        label: Text("Laundry Service"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[7],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[7] = !facility[7];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Laundry Service")
                                ? fcl.remove("Laundry Service")
                                : fcl.add("Laundry Service");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[8] ? Icon(Icons.done) : null,
                        label: Text("Maternity & NICU"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[8],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[8] = !facility[8];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Maternity & NICU")
                                ? fcl.remove("Maternity & NICU")
                                : fcl.add("Maternity & NICU");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[9] ? Icon(Icons.done) : null,
                        label: Text("Mini Kitchen"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[9],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[9] = !facility[9];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Mini Kitchen")
                                ? fcl.remove("Mini Kitchen")
                                : fcl.add("Mini Kitchen");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[10] ? Icon(Icons.done) : null,
                        label: Text("Operation Theatre"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[10],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[10] = !facility[10];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Operation Theatre")
                                ? fcl.remove("Operation Theatre")
                                : fcl.add("Operation Theatre");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[11] ? Icon(Icons.done) : null,
                        label: Text("Opthal Shop"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[11],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[11] = !facility[11];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Opthal Shop")
                                ? fcl.remove("Opthal Shop")
                                : fcl.add("Opthal Shop");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[12] ? Icon(Icons.done) : null,
                        label: Text("Parking"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[12],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[12] = !facility[12];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Parking")
                                ? fcl.remove("Parking")
                                : fcl.add("Parking");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[13] ? Icon(Icons.done) : null,
                        label: Text("Pharmacy"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[13],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[13] = !facility[13];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Pharmacy")
                                ? fcl.remove("Pharmacy")
                                : fcl.add("Pharmacy");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[14] ? Icon(Icons.done) : null,
                        label: Text("Sofa"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[14],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[14] = !facility[14];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Sofa")
                                ? fcl.remove("Sofa")
                                : fcl.add("Sofa");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[15] ? Icon(Icons.done) : null,
                        label: Text("Spa"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[15],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[15] = !facility[15];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Spa")
                                ? fcl.remove("Spa")
                                : fcl.add("Spa");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[16] ? Icon(Icons.done) : null,
                        label: Text("TV"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[16],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[16] = !facility[16];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("TV")
                                ? fcl.remove("TV")
                                : fcl.add("TV");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[17] ? Icon(Icons.done) : null,
                        label: Text("Video consultation"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[17],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[17] = !facility[17];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Video consultation")
                                ? fcl.remove("Video consultation")
                                : fcl.add("Video consultation");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[18] ? Icon(Icons.done) : null,
                        label: Text("Wifi"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[18],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[18] = !facility[18];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("Wifi")
                                ? fcl.remove("Wifi")
                                : fcl.add("Wifi");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                      ChoiceChip(
                        avatar: facility[19] ? Icon(Icons.done) : null,
                        label: Text("X-Ray"),
                        labelStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        selected: facility[19],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color(0xffededed),
                        onSelected: (bool selected) {
                          setState(() {
                            facility[19] = !facility[19];
                            //splValues1.add(widget.chipName);
                            //print(splValues1);
                            fcl.contains("X-Ray")
                                ? fcl.remove("X-Ray")
                                : fcl.add("X-Ray");
                            print(fcl.length);
                            print(fcl.toString());
                          });
                          // splValues2.add(splValues1.toString());
                          // print(splValues2.toString());
                        },
                        selectedColor: Color(0xffededed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      case 9:
        setState(() {});
        return new Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Insurance/TPA",
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
                  items: Dropdownlists()
                      .tpalist
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
                // TextFormField(
                //   decoration: new InputDecoration(
                //       // border: OutlineInputBorder(),
                //       // focusedBorder: InputBorder.none,
                //       // enabledBorder: InputBorder.none,
                //       //errorBorder: OutlineInputBorder(),
                //       //disabledBorder: InputBorder.none,
                //       // hintText: "Hospital Name"
                //       ),
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontFamily: 'Lato',
                //   ),
                //   controller: tpaController,
                // ),
                SizedBox(
                  height: 35,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 500,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: addTPA,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                        shape: CircleBorder(),
                        disabledColor: Colors.redAccent,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //Insurance Name
                Container(
                    child: Center(
                        child: dataBody3("Insurance Name",TPA))
//                  ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: healthCharges.length,
//                      itemBuilder: (_, index) => healthCharges[index]),
                ),
                // Container(
                //   child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: TPAInsurance.length,
                //       itemBuilder: (_, index) => TPAInsurance[index]),
                // ),
              ],
            ),
          ),
        );
      case 10:
        return new Container(
          //padding: EdgeInsets.all(20),
          // height: 1000,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          height:50,
                          width: 200,
                          child: CheckboxListTile(
                            title: Text('Finished adding data'),
                            value: _checked,
                            onChanged: (v){
                              setState(() {
                                _checked = !_checked;
                                buttonstatus = !buttonstatus;
                              });
                            },
                          ),
                        ),
                        MaterialButton(
                            disabledColor: Colors.grey,
                            color: Colors.redAccent,
                            child: Text("Submit Staff details"),
                            onPressed: buttonstatus?null:submitData
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          child: Text("Remove"),
                          onPressed: removeDynamicD,
                        ),
                         RaisedButton(
                          child: Text("Add Doctors"),
                          onPressed: addDynamicD,
                        ),

                      ],
                    ),
                    Doctor.length == 0 ? dynamicD() : resultD(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          child: Text("Remove"),
                          onPressed: removeDynamicN,
                        ),
                        RaisedButton(
                          child: Text("Add Nurses"),
                          onPressed: addDynamicN,
                        ),
                      ],
                    ),
                    Nurse.length == 0 ? dynamicN() : resultN(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          child: Text("Remove"),
                          onPressed: removeDynamicS,
                        ),
                        RaisedButton(
                          child: Text("Add Staffs"),
                          onPressed: addDynamicS,
                        ),
                      ],
                    ),
                    Staff.length == 0 ? dynamicS() : resultS(),

                  ]
              ),
            ),
          ),
        );
      case 11:
        return new Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: TextFormField(
              maxLines: 100,
              controller: tandccontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

          ),
        );

    }
  }

   dataBody(String item1, String item2, String item3, List Values) {
    return SingleChildScrollView(
      child: DataTable(
        sortAscending: true,
        columns: [
          DataColumn(
              label:  Text(item1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
          DataColumn(
              label: Text(item2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
          DataColumn(
              label: Text(item3,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
        ],
        rows: List.generate(
          Values.length,
              (index) {
            return DataRow(cells: [
              DataCell(
                  Center(
                      child: TextFormField(
                        initialValue: Values[index]['roomType'],
                        onFieldSubmitted: (v) {
                          setState(() {
                            Values[index]['roomType'] = v;
                          });
                          print(Values[index]['roomType']);
                        },
                      )),
                  showEditIcon: true),
              DataCell(
                  Center(
                      child: TextFormField(
                          initialValue: Values[index]['noOfBeds'],
                          onFieldSubmitted: (v) {
                            setState(() {
                              Values[index]['noOfBeds'] = v;
                            });
                            print(Values[index]['noOfBeds']);
                          })),
                  showEditIcon: true),
              DataCell(
                  Center(
                      child: TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                print("Onpressed");
                                setState(() {
                                  Values.removeAt(index);
                                });
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                          initialValue: Values[index]['charges'],
                          onFieldSubmitted: (v) {
                            setState(() {
                              Values[index]['charges'] = v;
                            });
                            print(Values[index]['charges']);
                          })),
                  showEditIcon: true),
            ]);
          },
        ),
        columnSpacing: MediaQuery.of(context).size.width * 9 / 100,
      ),
    );
  }
   dataBody1(String item1, String item2, List Values) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(item1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
          DataColumn(
              label: Text(item2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
        ],
        rows: List.generate(
          Values.length,
              (index) {
            return DataRow(cells: [
              DataCell(
                  Center(
                      child: TextFormField(
                          initialValue: Values[index][item1],
                          onChanged: (v) {
                            setState(() {
                              Values[index][item1] = v;
                            });
                            print(Values[index][item1]);
                          })),
                  showEditIcon: true),
              DataCell(
                  Center(
                      child: TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                print("Onpressed");
                                setState(() {
                                  if(Values==diagnosis) {
                                    diagnosis.removeAt(index);
                                  }else if(Values==health){
                                    health.removeAt(index);
                                  }
                                });
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: Values[index][item2],
                          onChanged: (v) {
                            setState(() {
                              Values[index][item2] = v;
                            });
                            print(Values[index][item2]);
                          })),
                  showEditIcon: true),
            ]);
          },
        ),
        columnSpacing: 100.0,
      ),
    );
  }
   dataBody2(String item1, String item2, List Values) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(item1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
          DataColumn(
              label: Text(item2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
        ],
        rows: List.generate(
          Values.length,
          (index) {
            return DataRow(cells: [
              DataCell(
                  Center(
                      child: TextFormField(

                          initialValue: Values[index][item1],
                          onChanged: (v) {
                            setState(() {
                              Values[index][item1] = v;
                            });
                            print(Values[index][item1]);
                          })),
                  showEditIcon: true),
              DataCell(
                  Center(
                      child: TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                print("Onpressed");
                                setState(() {
                                    surgery.removeAt(index);
                                });
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: Values[index][item2],
                          onChanged: (v) {
                            setState(() {
                              Values[index][item2] = v;
                            });
                            print(Values[index][item2]);
                          })),
                  showEditIcon: true),
            ]);
          },
        ),
        columnSpacing: 100.0,
      ),
    );
  }
   dataBody3(String title, List Values) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
        ],
        rows: List.generate(
          Values.length,
          (index) {
            return DataRow(cells: [
              DataCell(
                  Center(
                      child: TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                print("Onpressed");
                                setState(() {
                                  if(Values==TPA) {
                                    TPA.removeAt(index);
                                  }else if(Values==ACCRED){
                                    ACCRED.removeAt(index);
                                  }
                                });
                                print(TPA);
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                          initialValue: Values[index][title],
                          onChanged: (v) {
                            setState(() {
                              Values[index][title] = v;
                            });
                            print(Values[index][title]);
                          })),
                  showEditIcon: true,),
            ]);
          },
        ),
        columnSpacing: 100.0,
      ),
    );
  }

  clearText() {
    descController.clear();
    opdController.clear();
    packController.clear();
    surController.clear();
    amtController.clear();
    suramtController.clear();
    tpaController.clear();
    bedsController2.clear();
    chargesController2.clear();
    roomtype.clear();
  }

  addSpecialBeds() {
    Beds.add({
      "roomType": roomtype.text,
      "noOfBeds": bedsController2.text,
      "charges": chargesController2.text
    });
    setState(() {});
    print(Beds.toString());
    clearText();
  }

  addfreeBeds() {
    freebeds.add({
      "roomType": "100% free",
      "noOfBeds": bedsController.text,
      "charges": chargesController.text
    });
    conbeds.add({
      "roomType": "Concessional Beds",
      "noOfBeds": bedsController1.text,
      "charges": chargesController1.text
    });
    covidbeds.add({
      "roomType": "Covid Beds",
      "noOfBeds": bedsController3.text,
      "charges": chargesController3.text
    });
    print(Beds.toString());
  }

  addDiagnosisCharged() {
    diagnosis.add({
      "Type": descController.text,
      "charges": opdController.text
    });
    setState(() {});
    print(diagnosis.toString());
    clearText();
  }

  addHeathCheckup() {
    health.add(
        {"Type": packController.text, "charges": amtController.text});
    setState(() {});
    print(health.toString());
    clearText();
  }
  addSurgery() {
    surgery.add(
        {"Type": surController.text, "charges": suramtController.text});
    setState(() {});
    print(surgery.toString());
    clearText();
  }

  // adddocnamenumber(){
  //   print("Hey u clicked me");
  //   if( dynamicWidgetD().Doctor.text==""&&dynamicWidgetD().NumberD.text==""){
  //     docnamenum.add(
  //         {
  //           "Name": dynamicWidgetD().Doctor.text, "Number":dynamicWidgetD().NumberD.text,
  //         }
  //     );
  //   }
  //
  //   print(docnamenum);
  // }
  // addnursenamenumber(){
  //   nursenamenum.add(
  //     {
  //       "Name": dynamicWidgetN().Nurse.text, "Number":dynamicWidgetN().NumberN.text,
  //     }
  //   );
  //   print(nursenamenum.toString());
  // }
  // addstaffnamenumber(){
  //   staffnamenum.add(
  //     {
  //       "Name": dynamicWidgetS().Staff.text, "Number":dynamicWidgetS().NumberS.text,
  //     }
  //   );
  // }

  addTPA() {
    TPAInsurance.add(new AddInsurance(_chosenValue1));
    TPA.add({
      "Insurance Name": _chosenValue1,
    });
    setState(() {});
    print(TPA.toString());
    clearText();
  }
  addaccred(){
    Accred.add(new AddAccred(_chosenValue2));
    ACCRED.add({
      "Acredition": _chosenValue2,
    });
    setState(() {});
    print(ACCRED.toString());
  }

  Widget dynamicD(){
    Widget dynamicTextField = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.redAccent)
      ),
      height:200,
      child: new ListView.builder(
        itemCount: dynamicListD.length,
        itemBuilder: (_, index) => dynamicListD[index],
      ),
    );
    return dynamicTextField;
  }
  // List<Widget> _getDoctors() {
  //   List<Widget> doctorsTextFields = [];
  //   for (int i = 0; i < doctorsList.length; i++) {
  //     doctorsTextFields.add(Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 16.0),
  //       child: Row(
  //         children: [
  //           Expanded(child: DoctorsTextFields(i)),
  //           SizedBox(
  //             width: 16,
  //           ),
  //           // we need add button at last friends row
  //           _addRemoveButtonD(i == doctorsList.length - 1, i),
  //         ],
  //       ),
  //     ));
  //   }
  //   return doctorsTextFields;
  // }
  //
  // List<Widget> _getNurses() {
  //   List<Widget> nursesTextFields = [];
  //   for (int i = 0; i < nursesList.length; i++) {
  //     nursesTextFields.add(Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 16.0),
  //       child: Row(
  //         children: [
  //           Expanded(child: NursesTextFields(i)),
  //           SizedBox(
  //             width: 16,
  //           ),
  //           // we need add button at last friends row
  //           _addRemoveButtonN(i == nursesList.length - 1, i),
  //         ],
  //       ),
  //     ));
  //   }
  //   return nursesTextFields;
  // }
  //
  // List<Widget> _getStaffs() {
  //   List<Widget> staffsTextFields = [];
  //   for (int i = 0; i < staffsList.length; i++) {
  //     staffsTextFields.add(Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 16.0),
  //       child: Row(
  //         children: [
  //           Expanded(child: StaffsTextFields(i)),
  //           SizedBox(
  //             width: 16,
  //           ),
  //           // we need add button at last friends row
  //           _addRemoveButtonS(i == staffsList.length - 1, i),
  //         ],
  //       ),
  //     ));
  //   }
  //   return staffsTextFields;
  // }
  //
  // /// add / remove button
  // Widget _addRemoveButtonD(bool add, int index) {
  //   return InkWell(
  //     onTap: () {
  //       if (add) {
  //         doctorsList.insert(0, null);
  //       } else
  //         doctorsList.removeAt(index);
  //       setState(() {});
  //     },
  //     child: Container(
  //       width: 30,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: (add) ? Colors.green : Colors.red,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Icon(
  //         (add) ? Icons.add : Icons.remove,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _addRemoveButtonN(bool add, int index) {
  //   return InkWell(
  //     onTap: () {
  //       if (add) {
  //         // add new text-fields at the top of all friends textfields
  //         nursesList.insert(0, null);
  //
  //         print(nursesList.toString());
  //       } else
  //         nursesList.removeAt(index);
  //       setState(() {});
  //     },
  //     child: Container(
  //       width: 30,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: (add) ? Colors.green : Colors.red,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Icon(
  //         (add) ? Icons.add : Icons.remove,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _addRemoveButtonS(bool add, int index) {
  //   return InkWell(
  //     onTap: () {
  //       if (add) {
  //         // add new text-fields at the top of all friends textfields
  //         staffsList.insert(0, null);
  //       } else
  //         staffsList.removeAt(index);
  //       setState(() {});
  //     },
  //     child: Container(
  //       width: 30,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: (add) ? Colors.green : Colors.red,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Icon(
  //         (add) ? Icons.add : Icons.remove,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
  addDynamicD(){
    if(Doctor.length != 0){

      Doctor = [];
      NumberD = [];
      Specialist = [];
      dynamicListD = [];
    }
    setState(() {});
    if (dynamicListD.length >= 10) {
      return;
    }
    dynamicListD.add(new dynamicWidgetD());
  }
  removeDynamicD(){
    if(Doctor.length != 0){

      Doctor = [];
      NumberD = [];
      Specialist = [];
      dynamicListD = [];
    }
    setState(() {});
    if (dynamicListD.length == 0 ) {
      return;
    }
    dynamicListD.removeLast();
    print("Yeahhhhh");
  }

  Widget resultD(){
    Widget resultD = Container(
      height: 200,
      child: new Card(
        child: ListView.builder(
          itemCount: Doctor.length,
          itemBuilder: (_, index) {
            return new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.only(left: 10.0),
                    child: new Text("${index + 1} : ${Doctor[index]}${NumberD[index]}${Specialist[index]}"),
                  ),
                  new Divider()
                ],
              ),
            );
          },
        ),
      ),
    );
    return resultD;
  }

  Widget dynamicN(){
    Widget dynamicTextField = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.redAccent)
      ),
      height: 200,
      child: new ListView.builder(
        itemCount: dynamicListN.length,
        itemBuilder: (_, index) => dynamicListN[index],
      ),
    );
    return dynamicTextField;
  }
  addDynamicN(){
    if(Nurse.length != 0){

      Nurse = [];
      NumberN = [];
      dynamicListN = [];
    }
    setState(() {});
    if (dynamicListN.length >= 10) {
      return;
    }
    dynamicListN.add(new dynamicWidgetN());
  }
  removeDynamicN(){
    if(Nurse.length != 0){

      Nurse = [];
      NumberN = [];
      dynamicListN = [];
    }
    setState(() {});
    if (dynamicListN.length == 0 ) {
      return;
    }
    dynamicListN.removeLast();
  }

  Widget resultN(){
    Widget resultN = new Flexible(
        flex: 1,
        child: new Card(
          child: ListView.builder(
            itemCount: Nurse.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text("${index + 1} : ${Nurse[index]}${NumberN[index]}"),
                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));
    return resultN;
  }

  Widget dynamicS(){
    Widget dynamicTextField = Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.redAccent)
      ),
      width: 400,
      child: new ListView.builder(
        itemCount: dynamicListS.length,
        itemBuilder: (_, index) => dynamicListS[index],
      ),
    );
    return dynamicTextField;
  }
  addDynamicS(){
    if(Staff.length != 0){

      Staff = [];
      NumberS = [];
      dynamicListS = [];
    }
    setState(() {});
    if (dynamicListS.length >= 10) {
      return;
    }
    dynamicListS.add(new dynamicWidgetS());
  }
  removeDynamicS(){
    if(Staff.length != 0){

      Staff = [];
      NumberS = [];
      dynamicListS = [];
    }
    setState(() {});
    if (dynamicListS.length == 0 ) {
      return;
    }
    dynamicListS.removeLast();
  }

  Widget resultS(){
    Widget resultS = new Flexible(
        flex: 1,
        child: new Card(
          child: ListView.builder(
            itemCount: Staff.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text("${index + 1} : ${Staff[index]}${NumberS[index]}"),
                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));
    return resultS;
  }

  submitData() {
    Doctor = [];
    NumberD = [];
    Specialist = [];
    dynamicListD.forEach((widget){
      doclist.add(
          {
            "Name":widget.Doctor.text,"Number":widget.NumberD.text,"Specialist":widget.Specialist.text,
          }
      );
      print(doclist);
    });
    setState(() {});
    print(doclist.length);
    Nurse = [];
    NumberN = [];
    dynamicListN.forEach((widget){
      nurlist.add(
          {
            "Name":widget.Nurse.text,"Number":widget.NumberN.text,
          }

      );
      print(nurlist);
    });
    setState(() {});
    print(nurlist.length);
    Staff = [];
    NumberS = [];
    dynamicListS.forEach((widget){
      stafflist.add(
          {
            "Name":widget.Staff.text,"Number":widget.NumberS.text,
          }

      );
      print(stafflist);
    });
    setState(() {});
    print(stafflist.length);
    AuthService().toast("Data Added Successfully");
  }
  showAlertDialog(BuildContext context) async{

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Exit"),
      onPressed:  () {
        if (widget.category=="Doctor") {
          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorNewDashboard(widget.id,widget.mobile,widget.category)),
                  );
        } else if((widget.category=="Patient")){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PatientNewDashboard(widget.id,widget.mobile,widget.category)),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HospitalDashboard(widget.id,widget.mobile,widget.category)),
          );
        }
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () async{
     Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exit Add Hospital"),
      content: Text("Your data will be lost if you go out"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class AddInsurance extends StatefulWidget {
  String insuranceName;

  AddInsurance(this.insuranceName);
  @override
  _AddInsuranceState createState() => _AddInsuranceState();
}

class _AddInsuranceState extends State<AddInsurance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(
            //   "Insurance Name:",
            //   style: new TextStyle(
            //       fontWeight: FontWeight.bold, fontFamily: "Lato", fontSize: 14),
            // ),
            Text("  " + widget.insuranceName,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Lato", fontSize: 14)),
          ],
        ));
  }
}
class AddAccred extends StatefulWidget {
  String accred;

  AddAccred(this.accred);
  @override
  _AddAccredState createState() => _AddAccredState();
}

class _AddAccredState extends State<AddAccred> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text(
            //   "Accredition:",
            //   style: new TextStyle(
            //       fontWeight: FontWeight.bold, fontFamily: "Lato", fontSize: 14),
            // ),
            Text(widget.accred,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: "Lato", fontSize: 14)),
          ],
        ));
  }
}

// class DoctorsTextFields extends StatefulWidget {
//   final int index;
//   DoctorsTextFields(this.index);
//   @override
//   _DoctorsTextFieldsState createState() => _DoctorsTextFieldsState();
// }
//
// class _DoctorsTextFieldsState extends State<DoctorsTextFields> {
//   TextEditingController _nameController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nameController.text = _AddHospitalState.doctorsList[widget.index] ?? '';
//     });
//
//     return TextFormField(
//       controller: _nameController,
//       onChanged: (v) => _AddHospitalState.doctorsList[widget.index] = v,
//       decoration: InputDecoration(hintText: 'Enter Doctor\'s name'),
//     );
//   }
// }
//
// class NursesTextFields extends StatefulWidget {
//   final int index;
//   NursesTextFields(this.index);
//   @override
//   _NursesTextFieldsState createState() => _NursesTextFieldsState();
// }
//
// class _NursesTextFieldsState extends State<NursesTextFields> {
//   TextEditingController _nameController;
//   TextEditingController _phoneController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _phoneController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nameController.text = _AddHospitalState.nursesList[widget.index] ?? '';
//     });
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _phoneController.text = _AddHospitalState.nursesList[widget.index] ?? '';
//     });
//
//     return Row(
//       children: [
//         Container(
//           width: 100,
//           child: TextFormField(
//             controller: _nameController,
//             onChanged: (v) => {
//               _AddHospitalState.nursesList[widget.index] = v,
//               _AddHospitalState().nurlist["Name${widget.index}"] = v,
//             },
//             decoration: InputDecoration(hintText: 'Enter Nurse\'s name'),
//             validator: (v) {
//               if (v.trim().isEmpty) return 'Please enter something';
//               return null;
//             },
//           ),
//         ),
//         Container(
//           width: 150,
//           child: TextFormField(
//             controller: _phoneController,
//             onChanged: (v) => {
//               _AddHospitalState.nursesList[widget.index] = v,
//               _AddHospitalState().nurlist["Number${widget.index}"] = v,
//             },
//             decoration: InputDecoration(hintText: 'Enter Nurse\'s Number'),
//             validator: (v) {
//               if (v.trim().isEmpty) return 'Please enter something';
//               return null;
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class StaffsTextFields extends StatefulWidget {
//   final int index;
//   StaffsTextFields(this.index);
//   @override
//   _StaffsTextFieldsState createState() => _StaffsTextFieldsState();
// }
//
// class _StaffsTextFieldsState extends State<StaffsTextFields> {
//   TextEditingController _nameController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nameController.text = _AddHospitalState.staffsList[widget.index] ?? '';
//     });
//
//     return TextFormField(
//       controller: _nameController,
//       onChanged: (v) => _AddHospitalState.staffsList[widget.index] = v,
//       decoration: InputDecoration(hintText: 'Enter Staff\'s name'),
//     );
//   }
// }


class dynamicWidgetD extends StatelessWidget {
  TextEditingController Doctor = new TextEditingController();
  TextEditingController NumberD = new TextEditingController();
  TextEditingController Specialist = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
//      margin: new EdgeInsets.all(8.0),
      child:Row(
        children: <Widget>[
          Expanded(

            child: Container(
              height: 40,
              width: 140,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: new TextFormField(
                controller: Doctor,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    labelText: 'Doctor Name',
                    border: OutlineInputBorder()
                ),
              ),
            ),
          ),
          Expanded(

            child: Container(
              height: 40,
              width: 115,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: new TextFormField(
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: NumberD,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    labelText: 'Number',
                    border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Expanded(

            child: Container(
              height: 40,
              width: 110,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: new TextFormField(
                // inputFormatters: <TextInputFormatter>[
                //   LengthLimitingTextInputFormatter(10),
                //   // FilteringTextInputFormatter.digitsOnly
                // ],
                controller: Specialist,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    labelText: 'Specialist',
                    border: OutlineInputBorder()
                ),
                // keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class dynamicWidgetN extends StatelessWidget {
  TextEditingController Nurse = new TextEditingController();
  TextEditingController NumberN  = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
//      margin: new EdgeInsets.all(8.0),
      child:Row(
        children: <Widget>[
          Container(
            height: 40,
            width: 200,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: new TextFormField(
              controller: Nurse,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  labelText: 'Nurse Name',
                  border: OutlineInputBorder()
              ),
            ),
          ),
          Container(
            height: 40,
            width: 150,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: new TextFormField(
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: NumberN,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  labelText: 'Number',
                  border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
class dynamicWidgetS extends StatelessWidget {
  TextEditingController Staff = new TextEditingController();
  TextEditingController NumberS = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
//      margin: new EdgeInsets.all(8.0),
      child:Row(
        children: <Widget>[
          Container(
            height: 40,
            width: 200,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: new TextFormField(
              controller: Staff,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  labelText: 'Staff Name',
                  border: OutlineInputBorder()
              ),
            ),
          ),
          Container(
            height: 40,
            width: 150,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: new TextFormField(
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: NumberS,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  labelText: 'Number',
                  border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 16 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 16 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
