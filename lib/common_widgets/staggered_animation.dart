import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

/// Helper widget for staggered list animations
class StaggeredAnimation extends StatelessWidget {
  /// constructor for the class
  const StaggeredAnimation({
    Key key,
    @required this.index,
    @required this.child,
  }) : super(key: key);

  /// the current index of the animated card
  final int index;

  /// the widget that should be animated
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 250),
      child: SlideAnimation(
        verticalOffset: 30.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
