import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korani/surahtile.dart';
import 'package:korani/utils/callbacks.dart';
import 'package:korani/utils/helpers/custom_button.dart';
import 'package:korani/utils/helpers/custom_icon_button.dart';
import 'package:korani/utils/helpers/custom_text.dart';
import 'package:quran/quran.dart' as quran;
import 'utils/globals.dart';
import 'utils/helpers/application_title.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final int surah = Random().nextInt(114) + 1;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    userData!.put("first_time", false);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(backgroundColor: grey, leading: CustomizedIconButton(func: () {}, icon: FontAwesomeIcons.barsProgress), title: const AppTitle()),
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CustomizedText(text: "Assalamualaikum", color: white, fontSize: 25, fontWeight: FontWeight.bold),
            const SizedBox(height: 10),
            StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) _) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: userData!.get("name").isEmpty ? "USER" : userData!.get("name").toUpperCase(),
                                  labelText: userData!.get("name").isEmpty ? "USER" : userData!.get("name").toUpperCase(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                const Spacer(),
                                Buttoned(
                                  text: "CHANGE",
                                  callback: () async {
                                    await userData!.put("name", _nameController.text.trim());
                                    show("Name Changed");
                                    _(() {});
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(width: 10),
                                Buttoned(text: "CANCEL", callback: () => Navigator.pop(context)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: CustomizedText(text: userData!.get("name").isEmpty ? "USER" : userData!.get("name").toUpperCase(), color: white, fontSize: 35, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: const LinearGradient(colors: <Color>[white, purple], begin: AlignmentDirectional.bottomEnd, end: AlignmentDirectional.bottomEnd, tileMode: TileMode.clamp)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          width: 150,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.bookOpen, size: 20, color: white),
                              SizedBox(width: 10),
                              CustomizedText(text: "Last Read", color: white, fontSize: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomizedText(text: quran.getSurahName(surah), color: white, fontSize: 20, fontWeight: FontWeight.bold),
                        const SizedBox(height: 10),
                        CustomizedText(text: "Ayah No : ${Random().nextInt(quran.getVerseCount(surah)) + 1}", color: white, fontSize: 18),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset("assets/book.png", width: MediaQuery.of(context).size.width * .4, height: MediaQuery.of(context).size.height * .4),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) => SurahTile(number: index + 1),
                separatorBuilder: (BuildContext context, int index) => Container(width: MediaQuery.of(context).size.width, height: .2, decoration: BoxDecoration(color: white.withOpacity(.8), borderRadius: BorderRadius.circular(15))),
                itemCount: quran.totalSurahCount,
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
