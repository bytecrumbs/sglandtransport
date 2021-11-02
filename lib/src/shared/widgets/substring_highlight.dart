import 'package:flutter/material.dart';

class SubstringHighlight extends StatelessWidget {
  const SubstringHighlight({
    Key? key,
    required this.text,
    required this.term,
    this.textStyle = const TextStyle(
      color: Colors.black,
    ),
    this.textStyleHighlight = const TextStyle(
      backgroundColor: Colors.red,
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);

  final String text;
  final String term;
  final TextStyle textStyle;
  final TextStyle textStyleHighlight;

  @override
  Widget build(BuildContext context) {
    if (term.isEmpty) {
      return Text(text, style: textStyle);
    } else {
      final termLC = term.toLowerCase();

      final children = <InlineSpan>[];
      final spanList = text.toLowerCase().split(termLC);
      var i = 0;
      for (final v in spanList) {
        if (v.isNotEmpty) {
          children.add(TextSpan(
              text: text.substring(i, i + v.length), style: textStyle));
          i += v.length;
        }
        if (i < text.length) {
          children.add(TextSpan(
              text: text.substring(i, i + term.length),
              style: textStyleHighlight));
          i += term.length;
        }
      }
      return RichText(text: TextSpan(children: children));
    }
  }
}
