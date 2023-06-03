import 'package:flutter/material.dart';

class MainContentMargin extends StatelessWidget {
  const MainContentMargin({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}
