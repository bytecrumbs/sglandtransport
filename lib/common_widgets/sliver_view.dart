import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/search/custom_search_delegate.dart';

/// Defines whether the flare animation should loop or be idle. It is done like
/// this (rather than using a useState hook), so that for the integration tests,
/// this value can easily be overriden
final isFlareAnimationLoopStateProvider = StateProvider<bool>((ref) => true);

/// Main Sliver view, which can be used to wrap a child in it.
class SliverView extends HookWidget {
  /// The default constructor of the class
  const SliverView({
    Key? key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  /// The title to be shown in the app bar
  final String title;

  /// The child widget that should be shown in the sliver
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(true);
    final isPartiallyExpanded = useState(true);
    final isFlareAnimationLoop = useProvider(isFlareAnimationLoopStateProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final _sliverAnimationHeight = screenHeight * 0.32;
    final appBarColor =
        isExpanded.value ? Theme.of(context).primaryColorDark : Colors.white;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {
        isExpanded.value =
            scrollState.metrics.pixels < _sliverAnimationHeight / 1.5;
        isPartiallyExpanded.value = scrollState.metrics.pixels < 40;
        return isExpanded.value;
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: appBarColor),
            title: Text(
              title,
              style: TextStyle(color: appBarColor),
            ),
            pinned: true,
            expandedHeight: _sliverAnimationHeight,
            backgroundColor: isPartiallyExpanded.value
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).primaryColorDark,
            flexibleSpace: FlexibleSpaceBar(
              background: FlareActor.asset(
                AssetFlare(bundle: rootBundle, name: 'images/city.flr'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                animation: isFlareAnimationLoop.state ? 'Loop' : 'Idle',
              ),
            ),
            actions: <Widget>[
              IconButton(
                key: const ValueKey('searchIconButton'),
                icon: const Icon(Icons.search, size: 27),
                onPressed: () {
                  showSearch<dynamic>(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [child],
            ),
          ),
        ],
      ),
    );
  }
}
