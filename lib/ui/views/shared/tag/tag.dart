import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  Tag({@required this.text, this.color});
  final String text;
  final Color color;

  Widget _displayTagForSmallDevice(context) {
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
        ? _displayTagForSmallDevice(context)
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
