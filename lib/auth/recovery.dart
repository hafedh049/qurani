import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../constants.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  bool sent = false;
  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: CustomizedIconButton(
          func: () {
            Navigator.pop(context);
          },
          icon: FontAwesomeIcons.chevronLeft,
          color: purple,
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: LottieBuilder.asset(
                  "assets/email.json",
                  width: MediaQuery.of(context).size.width * .7,
                  height: MediaQuery.of(context).size.width * .5,
                ),
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
                  focusedBorder: OutlineInputBorder(
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
              StatefulBuilder(builder:
                  (BuildContext context, void Function(void Function()) setS) {
                return InkWell(
                  highlightColor: transparent,
                  focusColor: transparent,
                  hoverColor: transparent,
                  splashColor: transparent,
                  onTap: sent
                      ? null
                      : () async {
                          try {
                            if (_formKey.currentState!.validate()) {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                email: email.text.trim(),
                              )
                                  .then(
                                (void value) {
                                  setS(
                                    () => sent = true,
                                  );
                                  show(
                                      "Recovery link has been sent to your email check the inbox or the spam section and thanks. ♥");
                                },
                              );
                            }
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
                        color: sent ? whiteShade : purple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Center(
                        child: Text(
                          sent ? "Request sent" : 'Update',
                          style: TextStyle(color: white),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
