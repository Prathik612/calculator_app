import 'package:flutter/material.dart';

///Custom widget for the buttons in the calculator application
class Bttn extends StatelessWidget {
  
  final color;
  final txtColor;
  final String bttnTxt;
  final ontap;

  const Bttn(
      {super.key,
      this.color,
      this.txtColor,
      required this.bttnTxt,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: Text(
            bttnTxt,
            style: TextStyle(
              color: txtColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}