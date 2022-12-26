import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            const SizedBox(height: 60),
            CustomizedText(
              text: "Quran Application",
              color: purple,
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
                  borderRadius: BorderRadius.circular(15),
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
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              highlightColor: transparent,
              focusColor: transparent,
              hoverColor: transparent,
              splashColor: transparent,
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({"state": true}).then(
                  (void value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Welcome(),
                    ),
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * .5,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: const Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
