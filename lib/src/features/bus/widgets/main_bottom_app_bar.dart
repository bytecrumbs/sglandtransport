import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../constants/palette.dart';

class MainBottomAppBar extends StatelessWidget {
  const MainBottomAppBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  final int activeIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      items: const [
        TabItem<IconData>(
          icon: Icons.location_searching,
          title: 'Nearby Stops',
        ),
        TabItem<IconData>(
          icon: Icons.favorite,
          title: 'Favorite Buses',
        )
      ],
      initialActiveIndex: activeIndex,
      onTap: onTap,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      color: kPrimaryColor,
      activeColor: kAccentColor,
      top: -25,
      style: TabStyle.react,
    );
  }
}
