import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarogya_mydoctor/improvement/dropdownlists.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_new_dashboard.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_new_dashboard.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mock_data/mock_data.dart';
import 'package:file_picker/file_picker.dart';

import 'HospitalDashboard.dart';

class EditAddHospital extends StatefulWidget {
  final Hospital hospitalValues;
  final String key1;
  final String id;
  final String mobile;
  final String category;
  EditAddHospital(this.hospitalValues,this.key1,this.id,this.mobile,this.category);

  @override
  _EditAddHospital createState() => _EditAddHospital();
}

class _EditAddHospital extends State<EditAddHospital> {
  TextEditingController _nameController;
  static List<String> doctorsList = [null];
  static List nursesList = [null];
  static List<String> staffsList = [null];
  StorageTaskSnapshot downloadUrl;
  List<String> imagesUrl = [];
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
  List diagnosis1 = [];
  List health = [];
  List health1 = [];
  List surgery = [];
  List surgery1 = [];
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
      "Surgery Details",
      "Speciality",
      "Facility",
      "Staff Details",
      "Insurance",
      "Terms and Conditions",
    ];
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
  String popop = mockString(50);
  int pageindex = 0;
  String _chosenValue1 = "Aditya Birla Health Insurance Co. Ltd.";
  String _chosenValue2 = "NABH- National Accreditation Board for Hospitals and Healthcare Providers";
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
  bool pressed = false;
  List<String> NumberD = [];
  List<String>Doctor = [];
  List<String>Specialist = [];
  List<String> NumberN = [];
  List<String>Nurse = [];
  List<String> NumberS = [];
  List<String>Staff = [];
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
  final TextEditingController chargesController3 = TextEditingController();
  final TextEditingController notecontroller = TextEditingController();
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

  List<bool> _selected = [false, false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false];
  List<bool> facility = [false, false, false, false, false, false, false, false, false, false,false, false,
    false, false,false, false, false, false, false, false, false
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    nameController.text = widget.hospitalValues.hospitalName;
    regController.text = widget.hospitalValues.hospitalRegNo;
    addressController.text = widget.hospitalValues.hospitalAddress;
    dateofController.text = widget.hospitalValues.dateofIncorporation;
    adminiController.text = widget.hospitalValues.adminName;
    adminiphoneController.text = widget.hospitalValues.adminPh;
    // accredController.text = widget.hospitalValues.accred[0];
    // Accred.add(widget.hospitalValues.accred);
    awardsController.text = widget.hospitalValues.award;
    ambuController.text = widget.hospitalValues.ambulanceNo;
    emerController.text = widget.hospitalValues.emergencyNo;
    opdbkController.text = widget.hospitalValues.opdBookingNo;
    bookphController.text = widget.hospitalValues.bookingPhNo;
    pincode.text = widget.hospitalValues.pincode;
    bedsController.text =  widget.hospitalValues.freebeds[0].noOfBeds;
    bedsController1.text =  widget.hospitalValues.conbeds[0].noOfBeds;
    bedsController3.text =  widget.hospitalValues.covidbeds[0].noOfBeds;
    chargesController.text =  widget.hospitalValues.freebeds[0].charges;
    chargesController1.text =  widget.hospitalValues.conbeds[0].charges;
    chargesController3.text =  widget.hospitalValues.covidbeds[0].charges;
    tandccontroller.text =  widget.hospitalValues.termsandconditions;
    notecontroller.text = widget.hospitalValues.note;
    for(int i=0;i<widget.hospitalValues.beds.length;i++){
      Beds.add({
        "roomType": widget.hospitalValues.beds[i].roomType,
        "noOfBeds": widget.hospitalValues.beds[i].noOfBeds,
        "charges": widget.hospitalValues.beds[i].charges,
      });
    }
    print("uygfutfg"+widget.hospitalValues.award);
    // for(int i=0;i<widget.hospitalValues.diagnosis.length;i++) {
    //   diagnosis.add({
    //     "Type": widget.hospitalValues.diagnosis[i].test,
    //     "charges": widget.hospitalValues.diagnosis[i].charge,
    //   });
    // }
    // setState(() {});
    // for(int i=0;i<widget.hospitalValues.health.length;i++) {
    //   health.add(
    //       {
    //         "Type": widget.hospitalValues.health[i].packagename,
    //         "charges": widget.hospitalValues.health[i].amount
    //       });
    // }
    // setState(() {});
    // for(int i=0;i<widget.hospitalValues.surgery.length;i++) {
    //   surgery.add({
    //     "Type": widget.hospitalValues.surgery[i].surgeryname,
    //     "charges": widget.hospitalValues.surgery[i].suramount,
    //   });
    // }
    setState(() {});
    diagnosis1 = widget.hospitalValues.diagnosis;

    health1 = widget.hospitalValues.health;
    surgery1 = widget.hospitalValues.surgery;
    print(diagnosis);
    print(health);
    print(surgery);
    // imagesUrl = widget.hospitalValues.image;
    widget.hospitalValues.image.forEach((element) {
      imagesUrl.add(element);
    });
    print(imagesUrl);
    print(widget.hospitalValues.doctorslist);
    print(widget.hospitalValues.nurseslist);
    print(widget.hospitalValues.staffslist);
    widget.hospitalValues.doctorslist.forEach((element) {
      doclist.add(
          {
            "Name":element.name,"Number":element.phno,"Specialist":element.Specialist,
          }
      );
      Doctor.add(element.name);
      NumberD.add(element.phno);
      Specialist.add(element.Specialist);

    });
    widget.hospitalValues.nurseslist.forEach((element) {
      nurlist.add(
          {
            "Name":element.name,"Number":element.phno
          }
      );
      Nurse?.add(element.name);
      NumberN?.add(element.phno);

    });
    widget.hospitalValues.staffslist.forEach((element) {
      stafflist.add(
          {
            "Name":element.name,"Number":element.phno
          }
      );
      Staff?.add(element.name);
      NumberS?.add(element.phno);

    });
    // doclist.add(widget.hospitalValues.doctorslist);
    // nurlist.add(widget.hospitalValues.nurseslist);
    // stafflist.add(widget.hospitalValues.staffslist);
    print(widget.hospitalValues.tpalist[0].insurName);
    for(int i=0;i<widget.hospitalValues.tpalist.length;i++) {
      TPA.add({
        "Insurance Name": widget.hospitalValues.tpalist[i].insurName,
      });
    }
    for(int i=0;i<widget.hospitalValues.accred.length;i++) {
      ACCRED.add({
        "Acredition": widget.hospitalValues.accred[i].accredName,
      });
    }
    // TPA.add(widget.hospitalValues.tpalist);
    // fcl.add(widget.hospitalValues.facilities[0]);
    print(fcl.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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

  upload(filename, filepath) async {
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
    } else {
      print('Error from image repo ${snapshot.error.toString()}');
      throw ('This file is not an image');
    }
    print(imagesUrl.length);
    return imagesUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: (pageindex == 0)
                ? IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
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
                    : pageindex==9?Container():(Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              pageindex == 11
                  ? IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  showAlertDialog(context);
                },
                color: Colors.redAccent,
                iconSize: 30,
              )
                  : pageindex==9?Container():(IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (pageindex == 3) {
                    addfreeBeds();
                    print("page4");
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        pageindex++;
                      });
                    }
                  }else if(pageindex == 10){
                    if (_formKey.currentState.validate()&&_checked) {
                      _formKey.currentState.save();
                      setState(() {
                        pageindex++;
                      });
                    }else{
                      AuthService().toast("Please Complete filling data and Submit down below");
                    }
                  }else {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print("_formkeyValue::"+_formKey.toString());
                      setState(() {
                        pageindex++;
                      });
                    }
                  }
                },
                color: Colors.redAccent,
                iconSize: 30,
              )),
            ],
            backgroundColor: Colors.white,
            title: Text(
              topics[pageindex],
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 22.0,
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
                  controller: nameController,
                  decoration: new InputDecoration(
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
                  controller: regController,
                  decoration: new InputDecoration(
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
                  controller: addressController,
                  decoration: new InputDecoration(
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
                  controller: dateofController,
                  decoration: new InputDecoration(
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
                  controller: adminiController,
                  decoration: new InputDecoration(

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
                  controller: adminiphoneController,
                  decoration: new InputDecoration(

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
                  "Accredition",
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
                  "Pincode",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: pincode,
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
                  controller: awardsController,
                  decoration: new InputDecoration(

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
                  controller: ambuController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    // FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
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
                  controller: emerController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    // FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
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
                  controller: bookphController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    // FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(
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
                  controller: opdbkController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    // FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: new InputDecoration(

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
        return new Container(
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
                      "Add more images",
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
          padding: EdgeInsets.all(20),
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
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
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
                      width: 230,
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
                    child: Center(
                      child: dataBody(
                          "Room Type", "No of Beds", "Charges per day", Beds),
                    )
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
                        // height: 40,
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
                // Container(
                //   height: 200,
                // ),
                Container(
                    child: Center(
                        child:
                        dataBody1("Type", "charges", diagnosis))
//                  ListView.builder(
//                      shrinkWrap: true,
//                      itemCount: diagnosisCharge.length,
//                      itemBuilder: (_, index) => diagnosisCharge[index]),
                ),
                SizedBox(height: 10,),
                Text("Old Data",style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: diagnosis1.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      new Text("${index + 1} : Type.${diagnosis1[index].test}    ",style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                      ),),
                                      new Text("Charge.${diagnosis1[index].charge}",style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                      ),),

                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  new InkWell(
                                    onTap: (){
                                      setState(() {
                                        diagnosis1.removeAt(index);
                                      });
                                    },
                                    child: Expanded(
                                      child: Text("Delete",style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                        color: Colors.redAccent,
                                      ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Divider()
                          ],
                        ),
                      );
                    },
                  ),
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
                      flex:1,
                      child: Container(
                        // width: 110,
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
                      flex:1,
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
                          controller: packController,
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
                SizedBox(height: 10,),
                Text("Old Data",style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: health1.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: new EdgeInsets.all(1.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      new Text("${index + 1} : Type.${health1[index].packagename}",style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                      ),),
                                      new Text("Charge.${health1[index].amount}",style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                      ),),
                                    ],
                                  ),
                                  new InkWell(
                                    onTap: (){
                                      setState(() {
                                        health1.removeAt(index);
                                      });
                                    },
                                    child: Expanded(
                                      child: Text("Delete",style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                        color: Colors.redAccent,
                                      ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Divider()
                          ],
                        ),
                      );
                    },
                  ),
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
                      flex:1,
                      child: Container(
                        // width: 110,
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
                      flex:1,
                      child: Container(
                        // width: 110,
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
                          controller: surController,
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
                SizedBox(height: 10,),
                Text("Old Data",style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: surgery1.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      new Text("${index + 1} : Type.${surgery1[index].surgeryname}",style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Lato',
                                      ),),
                                       new Text("Charge.${surgery1[index].suramount}",style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Lato',
                                      ),),
                                    ],
                                  ),

                                  new InkWell(
                                    onTap: (){
                                      setState(() {
                                        surgery1.removeAt(index);
                                      });
                                    },
                                    child: Expanded(
                                      child: Text("Delete",style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                        color: Colors.redAccent,
                                      ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Divider()
                          ],
                        ),
                      );
                    },
                  ),
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
              Text("Selected Specialities: ",style:TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
              Wrap(
                spacing: 5.0,
                children: List.generate(widget.hospitalValues.specialities.length??0, (index) => ChoiceChip(
                  onSelected: (_){},
                    selectedColor: Color(0xffededed),
                    labelStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),selected:false,label: Text(widget.hospitalValues.specialities[index]))),
              ),
                SizedBox(
                  height: 10,
                ),
                Text("**Note: The old Specialities will be deleted so please select it again ",style:TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                )),
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
                Text("Selected Facilities: ",style:TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(widget.hospitalValues.facilities.length??0, (index) => ChoiceChip(
                      onSelected: (_){},
                      selectedColor: Color(0xffededed),
                      labelStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),selected:false,label: Text(widget.hospitalValues.facilities[index]))),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("**Note: The old Facilities will be deleted so please select it again ",style:TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                )),

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
                    RaisedButton(
                      child: Text("Add Doctors"),
                      onPressed: addDynamicD,
                    ),
                    Doctor.length == 0 ? dynamicD() : resultD(),
                    RaisedButton(
                      child: Text("Add Nurses"),
                      onPressed: addDynamicN,
                    ),
                    Nurse.length == 0 ? dynamicN() : resultN(),
                    RaisedButton(
                      child: Text("Add Staffs"),
                      onPressed: addDynamicS,
                    ),
                    Staff.length == 0 ? dynamicS() : resultS(),

                  ]
              ),
            ),
          ),
        );
      case 10:
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
  showAlertDialog(BuildContext context) async{
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        try {
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
            diagnosis1,
            health1,
            surgery1,
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
            widget.key1,
            "",
          );
        } catch (e) {
          print(e);
        }
        AuthService()
            .toast("Your Added Hospital Is Under Verification");
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
        pressed = false;
        print(pressed);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Back"),
      onPressed:  () async{
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Save"),
      content: Text("Are you sure you want to save the following hospital?"),
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
   dataBody(String item1, String item2, String item3, List Values) {
    return SingleChildScrollView(
      child: DataTable(
        sortAscending: true,
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
          DataColumn(
              label: Text("Charges",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Lato'))),
        ],
        rows: List.generate(
          Values.length,
              (index){
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
                                  Beds.removeAt(index);
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
        // columnSpacing: MediaQuery.of(context).size.width * 9 / 100,
      ),
    );
  }
   dataBody1(String item1, String item2, List Values) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
   dataBody2(String item1, String item2, List values1) {
    setState(() {});
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
          values1.length,
              (index) {

            return DataRow(cells: [
              DataCell(
                  Center(
                      child: TextFormField(
                          initialValue: values1[index][item1],
                          onChanged: (v) {
                            setState(() {
                              values1[index][item1] = v;
                            });
                            print(values1[index][item1]);
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
                          initialValue: values1[index][item2],
                          onChanged: (v) {
                            setState(() {
                              values1[index][item2] = v;
                            });
                            print(values1[index][item2]);
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
          Values.length??0,
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
    print(diagnosis.toString());
    clearText();
    setState(() {});
    diagnosis1.add({
      "Type": descController.text,
      "charges": opdController.text
    });


  }
  addHeathCheckup() {
    health.add(
        {"Type": packController.text, "charges": amtController.text});
    setState(() {});
    print(health.toString());
    clearText();
    health1.add(
        {"Type": packController.text, "charges": amtController.text});

  }
  addSurgery() {
    surgery.add(
        {"Type": surController.text, "charges": suramtController.text});
    setState(() {});
    print(surgery.toString());
    clearText();
    surgery1.add(
        {"Type": surController.text, "charges": suramtController.text});

  }
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
  addDynamicD(){
    pressed = false;
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
                    child: new Text("${index + 1} : Name.${Doctor[index]}  Mobile.${NumberD[index]}  Spl.${Specialist[index]}"),
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
    pressed = false;
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
  Widget resultN(){
    Widget resultN = new Container(
        height: 200,
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
                      child: new Text("${index + 1} : Name ${Nurse[index]} Mobile ${NumberN[index]}"),
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
    pressed = false;
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
  Widget resultS(){
    Widget resultS = new Container(
        height: 200,
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
                      child: new Text("${index + 1} : Name ${Staff[index]} Mobile ${NumberS[index]}"),
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
    // Doctor = [];
    // NumberD = [];
    // Specialist = [];
    if(pressed==false){
      dynamicListD.forEach((widget){
      doclist.add(
          {
            "Name":widget.Doctor.text,"Number":widget.NumberD.text,"Specialist":widget.Specialist.text,
          }
      );
      print(doclist);
    });
    setState(() {});
    print(doclist);
    // Nurse = [];
    // NumberN = [];
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
    // Staff = [];
    // NumberS = [];
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
    AuthService().toast("Data Added Sucessfully");
    if (_formKey.currentState.validate()&&_checked) {
      _formKey.currentState.save();
      setState(() {
        pageindex++;
      });
    }else{
      AuthService().toast("Please Complete filling data and Submit down below");
    }
    print(pressed);
    pressed = true;
    print(pressed);
    }else{
      AuthService().toast("Data Added Sucessfully");
      if (_formKey.currentState.validate()&&_checked) {
        _formKey.currentState.save();
        setState(() {
          pageindex++;
        });
      }
      print("Data not added again");
    }
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
          Container(
            height: 40,
            width: 140,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: new TextFormField(
              controller: Doctor,
              decoration: const InputDecoration(
                  labelText: 'Doctor Name',
                  border: OutlineInputBorder()
              ),
            ),
          ),
          Container(
            height: 40,
            width: 130,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: new TextFormField(
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(10),
                // FilteringTextInputFormatter.digitsOnly
              ],
              controller: NumberD,
              decoration: const InputDecoration(
                  labelText: 'Number',
                  border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
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
                  labelText: 'Specialist',
                  border: OutlineInputBorder()
              ),
              // keyboardType: TextInputType.number,
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
                // FilteringTextInputFormatter.digitsOnly
              ],
              controller: NumberN,
              decoration: const InputDecoration(
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
                // FilteringTextInputFormatter.digitsOnly
              ],
              controller: NumberS,
              decoration: const InputDecoration(
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
