import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korani/surahtile.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/quran.dart' as quran;
import 'constants.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: CustomizedIconButton(
            func: () {}, icon: FontAwesomeIcons.barsProgress),
        title: const AppTitle(),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomizedText(
              text: "Assalamualaikum",
              color: whiteShade,
            ),
            CustomizedText(
              text: "Si Hafedh Gunichi",
              color: white,
              fontSize: 20,
            ),
            const SizedBox(height: 10),
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
              child: LottieBuilder.asset(
                "assets/book.json",
                addRepaintBoundary: true,
                animate: true,
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return SurahTile(
                    number: index + 1,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: .2,
                    decoration: BoxDecoration(
                      color: whiteShade.withOpacity(.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                },
                itemCount: quran.totalSurahCount,
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
