import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color bgColor = const Color.fromARGB(255, 0, 24, 44);
Color white = Colors.white;
Color whiteShade = Colors.white.withOpacity(.4);
Color purple = const Color.fromARGB(255, 184, 113, 251);
Color transparent = Colors.transparent;

AssetsAudioPlayer recitator = AssetsAudioPlayer.newPlayer();
Future<void> recitate(String recitation) async {
  recitator.open(Audio.network(recitation));
}

void show(String text) {
  Fluttertoast.showToast(
    msg: text,
    fontSize: 16,
    toastLength: Toast.LENGTH_LONG,
  );
}

@immutable
// ignore: must_be_immutable
class CustomizedIconButton extends StatelessWidget {
  CustomizedIconButton({
    super.key,
    required this.func,
    required this.icon,
    this.size = 20,
    this.color = Colors.white,
  });
  double size;
  Color color;
  final IconData icon;
  final void Function() func;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: transparent,
      focusColor: transparent,
      hoverColor: transparent,
      splashColor: transparent,
      onPressed: func,
      icon: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomizedInkwell extends StatelessWidget {
  CustomizedInkwell({
    super.key,
    required this.func,
    required this.icon,
    this.size = 20,
    this.color = Colors.white,
  });
  double size;
  Color color;
  final IconData icon;
  final void Function() func;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: transparent,
      focusColor: transparent,
      hoverColor: transparent,
      splashColor: transparent,
      onTap: func,
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Quran App",
      softWrap: true,
      style: TextStyle(
        color: white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomizedText extends StatelessWidget {
  CustomizedText({
    super.key,
    required this.text,
    required this.color,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = "Roboto",
  });
  final String fontFamily;
  final String text;
  final Color color;
  double fontSize;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
