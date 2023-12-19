import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korani/utils/callbacks.dart';
import 'package:korani/utils/globals.dart';
import 'package:quran/quran.dart' as quran;

class PlayPause extends StatefulWidget {
  const PlayPause({super.key, required this.index, required this.surah});
  final int index;
  final int surah;
  @override
  State<PlayPause> createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> {
  bool _isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 500.ms,
      child: InkWell(
        onTap: () async {
          if (!_isPlaying) {
            await recitate(quran.getAudioURLByVerse(widget.surah, widget.index + 1));
          } else {
            await recitator.stop();
          }
          setState(() => _isPlaying = !_isPlaying);
        },
        child: Icon(_isPlaying ? FontAwesomeIcons.stop : FontAwesomeIcons.play, size: 20, color: purple),
      ),
    );
  }
}
