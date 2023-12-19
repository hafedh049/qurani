import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:korani/utils/globals.dart';
import 'package:path_provider/path_provider.dart';

Future<void> recitate(String recitation) async => recitator.open(Audio.network(recitation));

void show(String text) => Fluttertoast.showToast(msg: text, fontSize: 16, toastLength: Toast.LENGTH_LONG);

Future<bool> load() async {
  try {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    userData = await Hive.openBox("userData");
    if (userData!.isEmpty) {
      await userData!.putAll(<String, dynamic>{"first_time": true, "name": "User", "last_verse": 0, "last_surah": 0, "recitations": <String>[]});
    }
    return true;
  } catch (e) {
    show(e.toString());
    return false;
  }
}
