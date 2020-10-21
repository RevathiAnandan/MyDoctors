
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final searchData = [
    "hi",
    "hello",
    "welcome",
  ];
  final recent =[
    "hey",
    "sup?",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   return  Card(
     color: Colors.red,
     child: Center(
       child: Text(query),
     ),
   );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?recent:searchData.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index)=>ListTile(
        onTap: (){
          showResults(context);
        },
      leading: Icon(Icons.location_city),
      title: Text(suggestionList[index]),
    ),
      itemCount: suggestionList.length,
    );
  }

}
