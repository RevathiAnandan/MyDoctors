import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerExample extends StatefulWidget {
  @override
  _DateTimePickerExampleState createState() {
    return _DateTimePickerExampleState();
  }
}

class _DateTimePickerExampleState extends State<DateTimePickerExample> {
  DateTime date1;
  DateTime date2;
  DateTime date3;

  @override
  Widget build(BuildContext context) => Container(
      child: DateTimePickerFormField(
        inputType: InputType.both,
        format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
        editable: false,
        decoration: InputDecoration(
          border: InputBorder.none,
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
            labelText: 'Date and Time',
            hasFloatingPlaceholder: false
        ),
        onChanged: (dt) {
          setState(() => date1 = dt);
          print('Selected date: $date1');
        },
      ),
  );
}