import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korani/utils/globals.dart';
import 'package:korani/save_verse.dart';
import 'package:quran/quran.dart' as quran;

import 'utils/callbacks.dart';
import 'utils/helpers/custom_icon_button.dart';
import 'utils/helpers/custom_inkwell.dart';
import 'utils/helpers/custom_text.dart';

class Surah extends StatefulWidget {
  const Surah({super.key, required this.surah});
  final int surah;
  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  List<Map<String, dynamic>> userSavedVerses = <Map<String, dynamic>>[];

  @override
  void dispose() {
    recitator.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: grey,
        leading: CustomizedIconButton(func: () => Navigator.pop(context), icon: FontAwesomeIcons.chevronLeft, color: purple),
        title: CustomizedText(color: white, text: quran.getSurahName(widget.surah), fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(colors: <Color>[white, purple], begin: AlignmentDirectional.bottomEnd, end: AlignmentDirectional.bottomEnd, tileMode: TileMode.clamp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomizedText(text: quran.getSurahName(widget.surah), color: white, fontSize: 35, fontWeight: FontWeight.bold),
                  CustomizedText(text: '" ${quran.getSurahNameEnglish(widget.surah)} "', color: white, fontSize: 18),
                  Container(width: MediaQuery.of(context).size.width * .6, height: .5, decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(15))),
                  CustomizedText(text: "${quran.getPlaceOfRevelation(widget.surah).toUpperCase()} - ${quran.getVerseCount(widget.surah)} VERSES", color: white, fontSize: 18),
                  const CustomizedText(text: quran.basmala, color: white, fontSize: 38, fontFamily: "Calligraphy"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(color: white.withOpacity(.2), borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(radius: 15, backgroundColor: purple, child: CustomizedText(text: (index + 1).toString(), color: white, fontSize: 12)),
                              Container(height: 1, width: 10, color: purple, margin: const EdgeInsets.symmetric(horizontal: 4)),
                              CircleAvatar(radius: 15, backgroundColor: purple, child: CustomizedText(text: (index + 1).toString().split('').map((String e) => arabicNumbers[e]).join(), color: white)),
                              const Spacer(),
                              const SizedBox(width: 20),
                              SaveVerse(verse: index + 1, surah: widget.surah, userSavedVerses: userSavedVerses),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(alignment: AlignmentDirectional.centerEnd, child: CustomizedText(text: quran.getVerse(widget.surah, index + 1, verseEndSymbol: true), color: white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Align(alignment: AlignmentDirectional.centerStart, child: CustomizedText(text: quran.getVerseTranslation(widget.surah, index + 1), color: white)),
                      const SizedBox(height: 10),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Container(width: MediaQuery.of(context).size.width, height: .2, decoration: BoxDecoration(color: white.withOpacity(.8), borderRadius: BorderRadius.circular(15))),
                  );
                },
                itemCount: quran.getVerseCount(widget.surah),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
