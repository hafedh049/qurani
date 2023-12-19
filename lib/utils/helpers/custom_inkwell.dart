import 'package:flutter/material.dart';
import 'package:korani/utils/globals.dart';

// ignore: must_be_immutable
class CustomizedInkwell extends StatelessWidget {
  const CustomizedInkwell({super.key, required this.func, required this.icon, this.size = 20, this.color = Colors.white});
  final double size;
  final Color color;
  final IconData icon;
  final void Function() func;
  @override
  Widget build(BuildContext context) => InkWell(highlightColor: transparent, focusColor: transparent, hoverColor: transparent, splashColor: transparent, onTap: func, child: Icon(icon, size: size, color: color));
}
