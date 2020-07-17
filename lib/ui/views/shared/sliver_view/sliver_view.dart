import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:lta_datamall_flutter/environment_config.dart';
import 'package:lta_datamall_flutter/services/custom_search_delegate.dart';

class SliverView extends StatefulWidget {
  SliverView({Key key, @required this.title, @required this.child})
      : super(key: key);

  final String title;
  final Widget child;

  @override
  _SliverViewState createState() => _SliverViewState();
}

class _SliverViewState extends State<SliverView> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final _sliverAnimationHeight = screenHeight * 0.32;
    var appBarColor =
        _isExpanded ? Theme.of(context).primaryColorDark : Colors.white;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {
        setState(() {
          _isExpanded =
              scrollState.metrics.pixels < _sliverAnimationHeight / 1.5;
        });
        return _isExpanded;
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: appBarColor),
            title: Text(
              widget.title,
              style: TextStyle(color: appBarColor),
            ),
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: _sliverAnimationHeight,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: FlareActor.asset(
                AssetFlare(bundle: rootBundle, name: 'images/city.flr'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                animation:
                    EnvironmentConfig.is_flutter_drive_run ? 'Idle' : 'Loop',
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
              [widget.child],
            ),
          ),
        ],
      ),
    );
  }
}
