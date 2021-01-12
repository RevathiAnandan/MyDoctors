import 'package:flutter/material.dart';

class HospitalTerms extends StatelessWidget {
  final String terms;


  HospitalTerms(this.terms);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Text(terms),
          ),
        ),
      ),
    );
  }
}
