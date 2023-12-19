import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korani/utils/callbacks.dart';
import 'package:korani/utils/globals.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key, required this.verse, required this.surah});
  final int verse;
  final int surah;
  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  bool _isSaved = false;
  @override
  void initState() {
    _isSaved = userData!.get('recitations').contains(<String, int>{"verse_number": widget.verse, "surah_number": widget.verse});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 500.ms,
      child: InkWell(
        onTap: () async {
          if (_isSaved) {
            await userData!.put("recitations", userData!.get("recitations")..remove(<String, int>{"verse_number": widget.verse, "surah_number": widget.verse}));
            show("Item Removed");
          } else {
            await userData!.put("recitations", userData!.get("recitations")..add(<String, int>{"verse_number": widget.verse, "surah_number": widget.verse}));
            show("Item Saved");
          }
          setState(() => _isSaved = !_isSaved);
        },
        child: Icon(_isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark, size: 20, color: purple),
      ),
    );
  }
}
