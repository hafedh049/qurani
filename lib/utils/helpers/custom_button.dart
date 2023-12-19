import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:korani/utils/globals.dart';

class Buttoned extends StatefulWidget {
  const Buttoned({super.key, required this.text, required this.callback, this.fontSize = 16});
  final String text;
  final void Function() callback;
  final double fontSize;
  @override
  State<Buttoned> createState() => _ButtonedState();
}

class _ButtonedState extends State<Buttoned> {
  bool _colorState = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressDown: (LongPressDownDetails details) async {
        setState(() => _colorState = true);
        await Future.delayed(300.ms);
      },
      onLongPressUp: () async {
        setState(() => _colorState = false);
        await Future.delayed(300.ms);
        widget.callback();
      },
      onTapUp: (TapUpDetails details) async {
        setState(() => _colorState = false);
        await Future.delayed(700.ms);
        widget.callback();
      },
      onTapDown: (TapDownDetails details) async {
        setState(() => _colorState = true);
        await Future.delayed(300.ms);
      },
      child: AnimatedContainer(
        duration: 500.ms,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(width: 1, color: purple), borderRadius: BorderRadius.circular(5), color: _colorState ? purple : transparent),
        child: Center(child: Text(widget.text, style: TextStyle(fontWeight: FontWeight.w500, fontSize: widget.fontSize, color: _colorState ? white : null))),
      ),
    );
  }
}
