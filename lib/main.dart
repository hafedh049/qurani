import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korani/greetings.dart';
import 'auth/sign_in.dart';
import 'constants.dart';
import 'welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: bgColor,
      systemNavigationBarColor: bgColor,
    ),
  );
  /*await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.top],
  );*/
  runApp(Main());
  recitator.stop();
}

class Main extends StatelessWidget {
  Main({super.key});
  final Future<FirebaseApp> firebase = Firebase.initializeApp(
    name: "Qurani",
    options: const FirebaseOptions(
      apiKey: "AIzaSyBLRelZqUkvg-2hMPqcFkbdQluQJP_XJvw",
      appId: "1:609944131433:android:2b3da12228d827fefb8ff8",
      messagingSenderId: "609944131433",
      projectId: "qurani-2bc6f",
      storageBucket: "qurani-2bc6f.appspot.com",
      androidClientId:
          "609944131433-kq4hsaljmbafco7jfgd6v61dvjviofn2.apps.googleusercontent.com",
    ),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<FirebaseApp>(
        future: firebase,
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, snap) {
                if (snap.connectionState == ConnectionState.active) {
                  if (snap.data != null) {
                    return StreamBuilder<
                        DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              sn) {
                        if (sn.connectionState == ConnectionState.active) {
                          if (sn.data!.get("state")) {
                            return const Greetings();
                          } else {
                            return const Welcome();
                          }
                        } else if (sn.connectionState ==
                            ConnectionState.waiting) {
                          return Scaffold(
                            backgroundColor: bgColor,
                            body: Center(
                              child: CircularProgressIndicator(
                                color: purple,
                              ),
                            ),
                          );
                        } else {
                          show(sn.error.toString());
                          return Scaffold(
                            backgroundColor: bgColor,
                            body: Center(
                              child: CustomizedText(
                                text: sn.error.toString(),
                                color: white,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return const SignIn();
                  }
                } else if (snap.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    backgroundColor: bgColor,
                    body: Center(
                      child: CircularProgressIndicator(
                        color: purple,
                      ),
                    ),
                  );
                } else {
                  show(snap.error.toString());
                  return Scaffold(
                    backgroundColor: bgColor,
                    body: Center(
                      child: CustomizedText(
                        text: snap.error.toString(),
                        color: white,
                      ),
                    ),
                  );
                }
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: bgColor,
              body: Center(
                child: CircularProgressIndicator(
                  color: purple,
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: bgColor,
              body: Center(
                child: CustomizedText(
                  text: snapshot.error.toString(),
                  color: white,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
