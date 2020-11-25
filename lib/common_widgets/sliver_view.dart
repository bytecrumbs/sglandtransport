import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/search/custom_search_delegate.dart';
import '../environment_config.dart';

/// Provides info on whether the sliver is fully expanded or not
final isExpandedStateProvider = StateProvider<bool>((ref) => true);

/// Provides infor on whether the sliver is partially expanded or not
final isPartiallyExpandedStateProvider = StateProvider<bool>((ref) => true);

/// Main Sliver view, which can be used to wrap a child in it.
class SliverView extends HookWidget {
  /// The default constructor of the class
  SliverView({
    @required this.title,
    @required this.child,
  });

  /// The title to be shown in the app bar
  final String title;

  /// The child widget that should be shown in the sliver
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useProvider(isExpandedStateProvider);
    final isPartiallyExpanded = useProvider(isPartiallyExpandedStateProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final _sliverAnimationHeight = screenHeight * 0.32;
    var appBarColor =
        isExpanded.state ? Theme.of(context).primaryColorDark : Colors.white;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {
        isExpanded.state =
            scrollState.metrics.pixels < _sliverAnimationHeight / 1.5;
        isPartiallyExpanded.state = scrollState.metrics.pixels < 40;
        ;
        return isExpanded.state;
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
            floating: false,
            snap: false,
            expandedHeight: _sliverAnimationHeight,
            backgroundColor: isPartiallyExpanded.state
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).primaryColorDark,
            flexibleSpace: FlexibleSpaceBar(
              background: FlareActor.asset(
                AssetFlare(bundle: rootBundle, name: 'images/city.flr'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                animation:
                    EnvironmentConfig.isFlutterDriveRun ? 'Idle' : 'Loop',
              ),
            ),
            actions: <Widget>[
              IconButton(
                key: ValueKey('searchIconButton'),
                icon: Icon(Icons.search, size: 27),
                onPressed: () {
                  showSearch(
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
