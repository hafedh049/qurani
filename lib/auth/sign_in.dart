import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korani/auth/recovery.dart';
import 'package:korani/auth/sign_up.dart';
import 'package:korani/constants.dart';
import 'package:korani/welcome.dart';
import 'package:quran/quran.dart' as quran;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");

  bool isVisible = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Center(
                child: CustomizedText(
                  text: quran.basmala,
                  color: purple,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: TextStyle(color: white),
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: purple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: purple,
                    ),
                  ),
                  hintStyle: TextStyle(color: whiteShade),
                  hintText: 'E-mail',
                  prefixIcon: Icon(
                    FontAwesomeIcons.envelope,
                    color: purple,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setS) {
                  return TextField(
                    controller: password,
                    style: TextStyle(color: white),
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: purple,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
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
                      ),
                      suffixIcon: IconButton(
                        highlightColor: transparent,
                        focusColor: transparent,
                        hoverColor: transparent,
                        splashColor: transparent,
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
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
                    await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: email.text.trim(),
                      password: password.text.trim(),
                    )
                        .then(
                      (value) async {
                        show("user signed-in");
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Welcome(),
                          ),
                        );
                      },
                    );
                  } on String catch (_ /*,e*/) {
                    debugPrint(_);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Center(
                      child: Text(
                        'Sign-In',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PasswordRecovery(),
                      ),
                    );
                  },
                  child: Text(
                    "recover account",
                    style: TextStyle(color: purple),
                  ),
                ),
              ),
            ],
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUp(),
              ),
            );
          },
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "You don't have an account ? ",
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Create one',
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
