import 'package:flutter/material.dart';
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
    _isSaved = userData!.get('recitations').contains("${widget.surah}-${widget.verse}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: transparent,
      hoverColor: transparent,
      highlightColor: transparent,
      onTap: () async {
        if (_isSaved) {
          await userData!.put("recitations", userData!.get("recitations")..remove("${widget.surah}-${widget.verse}"));
          show("Item Removed");
        } else {
          await userData!.put("recitations", userData!.get("recitations")..add("${widget.surah}-${widget.verse}"));
          show("Item Saved");
        }
        setState(() => _isSaved = !_isSaved);
      },
      child: Icon(_isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark, size: 20, color: purple),
    );
  }
}
