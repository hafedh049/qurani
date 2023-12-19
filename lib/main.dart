import 'package:flutter/material.dart';
import 'package:korani/greetings.dart';
import 'package:korani/utils/callbacks.dart';
import 'utils/globals.dart';
import 'utils/helpers/custom_text.dart';
import 'welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
  recitator.stop();
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FutureBuilder<bool>(
        future: load(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (userData!.get("first_time")) {
              return const Greetings();
            } else {
              return const Welcome();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(backgroundColor: grey, body: Center(child: CircularProgressIndicator(color: purple)));
          } else {
            return Scaffold(backgroundColor: grey, body: Center(child: CustomizedText(text: snapshot.error.toString(), color: white)));
          }
        },
      ),
    );
  }
}
