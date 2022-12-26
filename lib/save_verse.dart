import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'package:quran/quran.dart' as quran;

class SaveVerse extends StatelessWidget {
  const SaveVerse({
    super.key,
    required this.userSavedVerses,
    required this.surah,
    required this.verse,
  });
  final int verse, surah;
  final List<Map<String, dynamic>> userSavedVerses;

  @override
  build(BuildContext context) {
    return CustomizedInkwell(
      func: () async {
        if (!userSavedVerses.any((Map<String, dynamic> element) =>
            element["verse_number"] == verse)) {
          userSavedVerses.add(
            {
              "surah_name": quran.getSurahName(surah),
              "surah_number": surah,
              "verse": quran.getVerse(surah, verse),
              "verse_number": verse,
              "verse_recitation_url":
                  quran.getAudioURLByVerse(surah, verse + 1),
              "save_date": Timestamp.now(),
            },
          );
        } else {
          userSavedVerses.removeWhere((Map<String, dynamic> element) =>
              element["verse_number"] == verse);
        }

        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          {
            "saved_verses": userSavedVerses,
          },
        );
      },
      icon: FontAwesomeIcons.bookmark,
      color: purple,
    );
  }
}
