import 'package:flutter/material.dart';

class MyPadding extends StatelessWidget {
  MyPadding(
      {required this.myString, required this.myPressed, required this.myColor});
  final VoidCallback myPressed;
  final String myString;
  final Color myColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: myColor,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: myPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            myString,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
