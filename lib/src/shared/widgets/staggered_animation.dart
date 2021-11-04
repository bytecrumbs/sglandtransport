import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredAnimation extends StatelessWidget {
  const StaggeredAnimation({
    Key? key,
    required this.index,
    required this.child,
  }) : super(key: key);

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 250),
      child: SlideAnimation(
        verticalOffset: 30,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
