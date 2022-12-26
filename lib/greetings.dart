import 'package:flutter/material.dart';
import 'package:korani/constants.dart';
import 'package:korani/welcome.dart';

class Greetings extends StatelessWidget {
  const Greetings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            CustomizedText(
              text: "Quran App",
              color: white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            CustomizedText(
              text: "Learn Quran and",
              color: whiteShade,
              fontSize: 20,
            ),
            const SizedBox(height: 5),
            CustomizedText(
              text: "Recite once everyday",
              color: whiteShade,
              fontSize: 20,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[purple, white],
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Welcome(),
                      ),
                    );
                  },
                  child: Image.asset(
                    "assets/book.png",
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .6,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
