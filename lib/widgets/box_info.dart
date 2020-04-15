import 'package:flutter/material.dart';

class BoxInfo extends StatelessWidget {
  const BoxInfo({
    Key key,
    @required this.child,
    @required this.color,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0.0, 0.0),
      constraints: const BoxConstraints(
        minWidth: 90,
        minHeight: 65,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        color: color,
      ),
      margin: const EdgeInsets.only(bottom: 17),
      padding: const EdgeInsets.all(10.0),
      child: child,
    );
  }
}
