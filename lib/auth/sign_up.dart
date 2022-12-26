import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korani/auth/sign_in.dart';
import 'package:korani/welcome.dart';
import 'package:quran/quran.dart' as quran;
import '../constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController englishUsername = TextEditingController();
  TextEditingController username = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    englishUsername.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CustomizedText(text: quran.basmala, color: purple),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: white),
                  controller: email,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "email is mandatory";
                    } else if (!value.toLowerCase().contains(
                        RegExp(r"[a-z]\w+\@[a-z][\w\.]+\.[a-z]{2,3}"))) {
                      return "email should be in this form : aaa@bbb.ccc";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: purple,
                      ),
                    ),
                    hintText: 'E-mail',
                    hintStyle: TextStyle(color: whiteShade),
                    prefixIcon: Icon(
                      FontAwesomeIcons.envelope,
                      color: purple,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(color: white),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "username can't be empty";
                    } else if (!value
                        .toLowerCase()
                        .contains(RegExp(r"^[a-z]+ ?[a-z]*$"))) {
                      return "username contains only alphabet and optionally one whitespace";
                    }
                    return null;
                  },
                  controller: englishUsername,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: purple,
                      ),
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: whiteShade),
                    prefixIcon: Icon(
                      FontAwesomeIcons.userDoctor,
                      color: purple,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(color: white),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "الاسم ضاروري";
                    } else if (!value.toLowerCase().contains(RegExp(r".+"))) {
                      return "الاسم يتكون من الحروف العربية";
                    }
                    return null;
                  },
                  controller: username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: purple,
                      ),
                    ),
                    hintText: 'الاسم بالعربية',
                    hintStyle: TextStyle(color: whiteShade),
                    prefixIcon: Icon(
                      FontAwesomeIcons.userGraduate,
                      color: purple,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setS) {
                    return TextFormField(
                      style: TextStyle(color: white),
                      controller: password,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "password is empty";
                        } else if (!value
                            .toLowerCase()
                            .contains(RegExp(r"^\w{4,}$"))) {
                          return "password lenght should be greater than 4";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: purple,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: whiteShade),
                        prefixIcon: Icon(
                          Icons.key,
                          color: purple,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility_off : Icons.visibility,
                            color: purple,
                          ),
                          onPressed: () {
                            setS(() => isVisible = !isVisible);
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                InkWell(
                  highlightColor: transparent,
                  focusColor: transparent,
                  hoverColor: transparent,
                  splashColor: transparent,
                  onTap: () async {
                    try {
                      if (formKey.currentState!.validate()) {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text.trim(),
                          password: password.text.trim(),
                        )
                            .then(
                          (void value) async {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email.text.trim(),
                              password: password.text.trim(),
                            );
                          },
                        ).then(
                          (void value) async {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set(
                              {
                                "uid": FirebaseAuth.instance.currentUser!.uid,
                                "email": email.text.trim(),
                                "password": password.text.trim(),
                                "arabic_username": username.text.trim(),
                                "english_username": englishUsername.text.trim(),
                                "creation_date": Timestamp.now(),
                                "saved_verses": [],
                                "greetings": false,
                              },
                            );
                          },
                        );
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Welcome(),
                        ),
                      );
                    } on String catch (_ /*,e*/) {
                      debugPrint(_);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Center(
                        child: Text(
                          'Sign-Up',
                          style: TextStyle(color: white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ),
            );
          },
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Already have an account ? ",
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Sign-In',
                  style: TextStyle(color: purple),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
