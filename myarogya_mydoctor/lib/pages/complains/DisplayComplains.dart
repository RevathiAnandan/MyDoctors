import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/dropdownlists.dart';
import 'package:myarogya_mydoctor/pages/complains/MyComplainList.dart';

import 'NewComplains.dart';

class DisplayComplains extends StatelessWidget {
  List<Widget> categories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.add,color: Colors.redAccent),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>MyComplainList(),
                ),
              );
            },),
        ],
        title: Text("My Complains",
            style: TextStyle(
                color: Colors.redAccent,
                fontFamily: "Lato",
                fontSize: 20)),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 5,
            child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, position) {
                  return Container(
                    color: Colors.black,
                    child: Stack(
                      // children: <Widget>[AppVideoPlayer(), onScreenControls()],
                    ),
                  );
                },
                itemCount: 10),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Center(child: Text("Issue Catogory"),),
                ),
                Flexible(
                  flex: 7,
                  child: ListView.builder(
                    itemCount: Dropdownlists().categories.length,
                    itemBuilder: (context,index){
                      return MaterialButton(
                        child: Text(Dropdownlists().categories[index],style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),),
                        onPressed: (){
                            filtercomplains(Dropdownlists().categories[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  filtercomplains(String catogory){

  }
}
