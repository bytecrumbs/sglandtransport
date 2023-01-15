import 'package:flutter/material.dart';

/// Shows a header section of the about view
class AboutHeader extends StatelessWidget {
  /// Constructor of the about header
  const AboutHeader({
    super.key,
    required this.headerText,
  });

  /// The text to be shown as a header
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
      child: Text(
        headerText,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
