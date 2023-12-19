import 'package:flutter/material.dart';
import 'package:korani/utils/globals.dart';

import 'utils/helpers/custom_text.dart';

class QuranDrawer extends StatelessWidget {
  const QuranDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            Container(
              width: 300.0,
              height: 150,
              decoration: const BoxDecoration(color: purple, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const CustomizedText(text: "مرحبا", color: white, fontSize: 20, fontWeight: FontWeight.bold),
                    const SizedBox(height: 10),
                    CustomizedText(text: userData!.get("arabic_username"), color: white, fontSize: 20, fontWeight: FontWeight.bold),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
