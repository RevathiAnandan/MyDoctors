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
  List <String> splValues=List();
ApiService api = new ApiService();

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          splValues.add(widget.chipName);
          print(splValues.toString());
//          ApiService().splValues.add(widget.chipName);
        });

        },
      selectedColor: Color(0xffeadffd),);
  }
}