import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget{
  final Size size;
  final IconData icon;
  final String hintText;


  const TextFieldContainer({Key key, this.size, this.icon, this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

}