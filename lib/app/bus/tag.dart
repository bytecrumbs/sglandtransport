import 'package:flutter/material.dart';

/// Shows the load of the bus
class Tag extends StatelessWidget {
  /// The default constructor of the class
  const Tag({Key? key, required this.text, this.color}) : super(key: key);

  /// The text that is shown, indicating the bus load
  final String text;

  /// The color that the text should be shown in
  final Color color;

  Widget _displayTagForSmallDevice() {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 340;
    return isSmall
        ? _displayTagForSmallDevice()
        : Container(
            margin: const EdgeInsets.only(right: 7),
            padding: const EdgeInsets.only(
              left: 3,
              right: 3,
              top: 5,
              bottom: 5,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
  }
}
