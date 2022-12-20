
import 'package:flutter/material.dart';

class AppTextFiled extends StatelessWidget {
  const AppTextFiled({
    Key? key,
    required this.controller,
    required this.hint,
    required this.lable,
    required this.suffixIcon,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.textColor = Colors.grey,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;
  final String hint;
  final String lable;
  final bool obscureText;
  final Color textColor;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.grey),
        suffixStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 20,
        ),
        hintText: hint,
        labelText: lable,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(suffixIcon,),
        enabledBorder: getBorder(),
        focusedBorder: getBorder(borderColor: Colors.green),
      ),
    );
  }
  OutlineInputBorder getBorder({Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      gapPadding: 10,
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
  }
}
