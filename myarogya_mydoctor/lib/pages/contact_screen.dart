
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';

class ContactsPage extends StatefulWidget {
  final String  mobile;
  final String  category;
  ContactsPage(this.mobile,this.category);
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool duplicate = false;
  List<Contact> _contacts;
  FirebaseDatabase fb = FirebaseDatabase.instance;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    var contacts = (await ContactsService.getContacts(withThumbnails: false,
      photoHighResolution: false,))
        .toList();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: (Text('Contacts')),
//      ),
      body: _contacts != null
      //Build a list view of all contacts, displaying their avatar and
      // display name
          ? ListView.builder(
        itemCount: _contacts?.length??0,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = _contacts?.elementAt(index);
          print(contact.phones);
          // print(contact.phones.elementAt(0).value);
          return Column(
            children: [
              ListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                    ? CircleAvatar(
                  backgroundImage: MemoryImage(contact.avatar),
                )
                    : CircleAvatar(
                  child: Text(contact.initials()),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                title: Text(contact.displayName ?? ''),
                // subtitle: ItemsTile(contact.phones),
                // Text(contact.phones.elementAt(0).value),
                // onTap: () async{
                //   print("${contact.displayName}""${contact.phones.elementAt(0).value}");
                //   showAlertDialog(context,contact.displayName,contact.phones.elementAt(0).value);
                // },
                //This can be further expanded to showing contacts detail
                // onPressed().
              ),
              ItemsTile(contact.phones,contact.displayName,widget.category,widget.mobile),
            ],
          );
        },
      )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  showAlertDialog(BuildContext context,String name,String mobile,String category,String phone) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Add"),
      onPressed:  () async{
//        if(widget.category == "MY PATIENT") {
//          ApiService().addPatientToDoctor(mobile, widget.mobile, name);
//          ApiService().addDoctorToPatient(mobile, widget.mobile, name);
//          Navigator.of(context).pop();
//        }else{
//          ApiService().addPatientToDoctor(widget.mobile, mobile, name);
//          ApiService().addDoctorToPatient(widget.mobile,mobile, name);
//          Navigator.of(context).pop();
//        }
//         print(widget.category);
        print(mobile);
        print(name);
        checkDuplication(mobile,name,category,phone,context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add Contact"),
      content: Text("Would you like to Add the Contact?"),
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

  checkDuplication(String phone,String name,String category,String mobile,BuildContext context){
    // print(widget.category);
    print(category);
    print(mobile);

    if(category == "MY PATIENT") {
      var db = fb.reference().child("User").child(mobile).child(
          "myPatient");
      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        print(snapshot.value);
        if (values == null) {
          duplicate = false;
        } else {
          values.forEach((key, values) {
            var refreshToken = values["phone"].toString();
            if (refreshToken == phone) {
              duplicate = true;
            }
            print("Values!!!" + values["phone"].toString());
            print(refreshToken);
            print(duplicate);
          });
        }
        checkDuplicate(phone, name,category,mobile,context);
      }
      );
    }else {
      var db = fb.reference().child("User").child(mobile).child(
          "myDoctor");
      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        print(snapshot.value);
        if (values == null) {
          duplicate = false;
        } else {
          values.forEach((key, values) {
            var refreshToken = values["phone"].toString();
            if (refreshToken == phone) {
              duplicate = true;
            }
            print("Values!!!" + values["phone"].toString());
            print(refreshToken);
            print(duplicate);
          });
        }
        checkDuplicate(phone, name,category,mobile,context);
      }
      );
    }
  }
  checkDuplicate(String mobile,String name,String category,String phone,BuildContext context){
    if(duplicate == false){
      if(category == "MY PATIENT") {
        ApiService().addPatientToDoctor(mobile, phone, name);
        ApiService().addDoctorToPatient(mobile, phone, name);
        Navigator.of(context).pop();
        AuthService().toast("Added Successfully");
      }else{
        ApiService().addPatientToDoctor(phone, mobile, name);
        ApiService().addDoctorToPatient(phone,mobile, name);
        Navigator.of(context).pop();
        AuthService().toast("Added Successfully");
      }
      print("not"+ duplicate.toString());
    }else if(duplicate == true){
      Navigator.pop(context);
      AuthService().toast("The Number Already Exist");
      duplicate = false;
      print("exist"+ duplicate.toString());
    }
  }
}
class ItemsTile extends StatefulWidget {
  ItemsTile( this._items,this.displayname,this.category,this.mobile);

  final Iterable<Item> _items;
  final String displayname;
  final String category;
  final String mobile;

  @override
  _ItemsTileState createState() => _ItemsTileState();
}

class _ItemsTileState extends State<ItemsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: widget._items
              .map(
                (i) => ListTile(
                  title: Text(i.label ?? ""),
                  subtitle: Text(i.value ?? ""),
                  trailing: MaterialButton(
                    color: Colors.redAccent,
                    child: Text("Add",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    onPressed: (){
                      _ContactsPageState().showAlertDialog(context,widget.displayname,i.value,widget.category,widget.mobile);
                    },
                  ),
                  onTap: () async{
                    print("${widget.displayname}""${i.value}");
                    _ContactsPageState().showAlertDialog(context,widget.displayname,i.value,widget.category,widget.mobile);
                  },
                ),
          )
              .toList(),
        ),
      ],
    );
  }
}