import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomizedText extends StatelessWidget {
  const CustomizedText({super.key, required this.text, required this.color, this.fontSize = 16, this.fontWeight = FontWeight.normal, this.fontFamily = "Roboto"});
  final String fontFamily;
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) => Text(text, softWrap: true, style: TextStyle(color: color, fontFamily: fontFamily, fontSize: fontSize, fontWeight: fontWeight));
}
