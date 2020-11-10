import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;
  List <String> splValues1=[];
  List <String> splValues2=[];
ApiService api = new ApiService();

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: _isSelected? Icon(Icons.done):null,
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Color(0xffededed),

      onSelected: (bool selected) {
        setState(() {
          _isSelected = !_isSelected;
          //splValues1.add(widget.chipName);
          //print(splValues1);
          splValues1.contains(widget.chipName)
              ? splValues1.remove(widget.chipName)
              : splValues1.add(widget.chipName);
          print(splValues1.toString());
        });
        // splValues2.add(splValues1.toString());
        // print(splValues2.toString());
        },
      selectedColor: Color(0xffededed),
    );
  }
}