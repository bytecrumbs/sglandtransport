import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  Tag({@required this.text});
  final String text;

  Widget _displayTagForSmallDevice(context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 340;
    print(isSmall);
    return isSmall
        ? _displayTagForSmallDevice(context)
        : Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              top: 5,
              bottom: 5,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 247, 248, 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
  }
}
