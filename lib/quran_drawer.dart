import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:korani/auth/sign_in.dart';
import 'package:korani/constants.dart';

class QuranDrawer extends StatelessWidget {
  const QuranDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: purple,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: CustomizedText(
                  text: "مرحبا",
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              highlightColor: transparent,
              focusColor: transparent,
              hoverColor: transparent,
              splashColor: transparent,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                    (route) => false);
              },
              child: CustomizedText(text: "Sign-Out", color: white),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
