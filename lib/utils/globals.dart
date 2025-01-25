import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const Color grey = Color.fromARGB(255, 40, 44, 52);
const Color white = Color.fromARGB(255, 215, 218, 224);
const Color purple = Color.fromARGB(255, 184, 113, 251);
const Color transparent = Colors.transparent;

final AssetsAudioPlayer recitator = AssetsAudioPlayer.newPlayer();

Box? userData;

const Map<String, String> arabicNumbers = <String, String>{"0": "٠", "1": "۱", "2": "۲", "3": "۳", "4": "٤", "5": "٥", "6": "٦", "7": "۷", "8": "۸", "9": "۹"};
