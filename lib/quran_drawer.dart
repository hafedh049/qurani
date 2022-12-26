import 'package:cloud_firestore/cloud_firestore.dart';
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
            const SizedBox(height: 40),
            Container(
              width: 300.0,
              height: 150,
              decoration: BoxDecoration(
                color: purple,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CustomizedText(
                      text: "مرحبا",
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return CustomizedText(
                            text: snapshot.hasData
                                ? snapshot.data!.get("arabic_username")
                                : "",
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          );
                        } else {
                          return CustomizedText(
                            text: snapshot.error.toString(),
                            color: white,
                            fontSize: 20,
                          );
                        }
                      },
                    ),
                  ],
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
                show("user signed-out");
                await FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ),
                        (route) => false,
                      ),
                    );
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
