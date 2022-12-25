import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korani/constants.dart';
import 'package:quran/quran.dart' as quran;

class Surah extends StatefulWidget {
  const Surah({
    super.key,
    required this.surah,
  });
  final int surah;
  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  @override
  void dispose() {
    recitator.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: CustomizedIconButton(
          func: () {
            Navigator.pop(context);
          },
          icon: FontAwesomeIcons.chevronLeft,
        ),
        title: CustomizedText(
          color: white,
          text: quran.getSurahName(widget.surah),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: <Color>[white, purple],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomizedText(
                    text: quran.getSurahName(widget.surah),
                    color: white,
                    fontSize: 35,
                  ),
                  CustomizedText(
                    text: quran.getSurahNameEnglish(widget.surah),
                    color: white,
                    fontSize: 18,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .6,
                    height: .2,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  CustomizedText(
                    text:
                        "${quran.getPlaceOfRevelation(widget.surah).toUpperCase()} - ${quran.getVerseCount(widget.surah)} surahS",
                    color: white,
                    fontSize: 18,
                  ),
                  CustomizedText(
                    text: quran.basmala,
                    color: white,
                    fontSize: 18,
                    fontFamily: "Calligraphy",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                          color: white.withOpacity(.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: purple,
                                child: CustomizedText(
                                  text: (index + 1).toString(),
                                  color: white,
                                ),
                              ),
                              const Spacer(),
                              CustomizedInkwell(
                                func: () {},
                                icon: FontAwesomeIcons.shareNodes,
                                color: purple,
                              ),
                              const SizedBox(width: 20),
                              CustomizedInkwell(
                                func: () {
                                  recitate(quran.getAudioURLByVerse(
                                      widget.surah, index + 1));
                                },
                                icon: FontAwesomeIcons.play,
                                color: purple,
                              ),
                              const SizedBox(width: 20),
                              CustomizedInkwell(
                                func: () {},
                                icon: FontAwesomeIcons.bookmark,
                                color: purple,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: CustomizedText(
                          text: quran.getVerse(
                            widget.surah,
                            index + 1,
                            verseEndSymbol: true,
                          ),
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomizedText(
                          text: quran.getVerseTranslation(
                            widget.surah,
                            index + 1,
                          ),
                          color: whiteShade,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: .2,
                      decoration: BoxDecoration(
                        color: whiteShade.withOpacity(.8),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
                itemCount: quran.getVerseCount(widget.surah),
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
                physics: const BouncingScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
