import 'package:flutter/material.dart';
import 'package:korani/utils/globals.dart';

@immutable
// ignore: must_be_immutable
class CustomizedIconButton extends StatelessWidget {
  CustomizedIconButton({super.key, required this.func, required this.icon, this.size = 20, this.color = Colors.white});
  double size;
  Color color;
  final IconData icon;
  final void Function() func;
  @override
  Widget build(BuildContext context) => IconButton(highlightColor: transparent, focusColor: transparent, hoverColor: transparent, splashColor: transparent, onPressed: func, icon: Icon(icon, size: size, color: color));
}
