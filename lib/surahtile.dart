import 'package:flutter/material.dart';
import 'package:korani/utils/globals.dart';
import 'package:korani/sixteensth_star.dart';
import 'package:korani/surah.dart';
import 'package:korani/utils/helpers/custom_text.dart';
import 'package:quran/quran.dart' as quran;

class SurahTile extends StatelessWidget {
  const SurahTile({super.key, required this.number});
  final int number;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        highlightColor: transparent,
        focusColor: transparent,
        hoverColor: transparent,
        splashColor: transparent,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Surah(surah: number))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(alignment: AlignmentDirectional.center, children: <Widget>[SixteenSideStar(), CustomizedText(text: number.toString(), color: white, fontWeight: FontWeight.normal, fontSize: 16)]),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomizedText(text: quran.getSurahName(number), color: white, fontWeight: FontWeight.bold),
                const SizedBox(height: 5),
                CustomizedText(color: white, text: "${quran.getPlaceOfRevelation(number).toUpperCase()} - ${quran.getVerseCount(number)} VERSES", fontSize: 16, fontWeight: FontWeight.normal),
              ],
            ),
            const Spacer(),
            CustomizedText(text: quran.getSurahNameArabic(number), color: const Color.fromARGB(255, 184, 113, 251), fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Calligraphy"),
          ],
        ),
      ),
    );
  }
}
