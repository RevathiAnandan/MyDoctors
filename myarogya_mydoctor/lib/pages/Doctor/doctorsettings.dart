import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:share/share.dart';

import 'edit_profile_doctor.dart';

class DoctorSettings extends StatefulWidget {
  String mobile;
  String id;
  DoctorSettings(this.id,this.mobile);
  @override
  _DoctorSettingsState createState() => _DoctorSettingsState();
}

class _DoctorSettingsState extends State<DoctorSettings> {
  String _linkMessage;
  bool _isCreatingLink = false;
  String _testString =
      "To test: long press link and then copy and click from a non-browser "
      "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
      "is properly setup. Look at firebase_dynamic_links/README.md for more "
      "details.";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.person,size: 30,color: Colors.redAccent,),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                 EditProfileDoctor(widget.id,widget.mobile)
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.memory,size: 30,color: Colors.redAccent,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "My Income",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.pan_tool,size: 30,color: Colors.redAccent,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "My Holdings",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.priority_high,size: 30,color: Colors.redAccent,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Privacy",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.border_color,size: 30,color: Colors.redAccent,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.local_offer,size: 30,color: Colors.redAccent,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Disclaimer",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: (){
                    _createDynamicLink(true);
                  },
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.people,size: 30,color: Colors.redAccent,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Invite a Friend",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: (){
                    AuthService().signOut(context);
                  },
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.file_upload,size: 30,color: Colors.redAccent,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            Navigator.pushNamed(context, deepLink.path);
          }
        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://myarogyamydoctor.page.link',
      link: Uri.parse('https://myarogyamydoctor.page.link/invite'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.myarogya_mydoctor',
        minimumVersion: 16,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
//      iosParameters: IosParameters(
//        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
//        minimumVersion: '0',
//      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
      print(url.toString());
      shareLink(context,url.toString(),_testString);
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  shareLink(BuildContext context,String url,String message){
    final RenderBox Box = context.findRenderObject();
    Share.share(
        url,
        subject: message,
        sharePositionOrigin: Box.localToGlobal(Offset.zero)&Box.size
    );
  }
}
