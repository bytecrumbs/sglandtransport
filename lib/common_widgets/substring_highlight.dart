library substring_highlight;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Widget that renders a string with sub-string highlighting.
class SubstringHighlight extends StatelessWidget {
  /// The String searched by {SubstringHighlight.term}.
  final String text;

  /// The sub-string that is highlighted inside {SubstringHighlight.text}.
  final String term;

  /// The {TextStyle} of the {SubstringHighlight.text} that isn't highlighted.
  final TextStyle textStyle;

  /// The {TextStyle} of the {SubstringHighlight.term}s found.
  final TextStyle textStyleHighlight;

  SubstringHighlight({
    Key? key,
    required this.text,
    required this.term,
    this.textStyle = const TextStyle(
      color: Colors.black,
    ),
    this.textStyleHighlight = const TextStyle(
      color: Colors.red,
    ),
  }) : super(key: key);

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
