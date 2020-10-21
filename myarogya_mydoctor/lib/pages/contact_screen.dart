
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';

class ContactsPage extends StatefulWidget {
  final String  mobile;
  final String  category;
  ContactsPage(this.mobile,this.category);
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
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
        itemCount: _contacts?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = _contacts?.elementAt(index);
          return ListTile(
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
            subtitle: Text(contact.phones.elementAt(0).value),
            onTap: () async{
              print("${contact.displayName}""${contact.phones.elementAt(0).value}");
              showAlertDialog(context,contact.displayName,contact.phones.elementAt(0).value);
            },
            //This can be further expanded to showing contacts detail
            // onPressed().
          );
        },
      )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  showAlertDialog(BuildContext context,String name,String mobile) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Add"),
      onPressed:  () async{
        if(widget.category == "MY PATIENT") {
          ApiService().addPatientToDoctor(mobile, widget.mobile, name);
          ApiService().addDoctorToPatient(mobile, widget.mobile, name);
          Navigator.of(context).pop();
        }else{
          ApiService().addPatientToDoctor(widget.mobile, mobile, name);
          ApiService().addDoctorToPatient(widget.mobile,mobile, name);
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
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
}