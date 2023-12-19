import 'package:flutter/material.dart';

import '../globals.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) => const Text("Quran App", softWrap: true, style: TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.bold));
}
