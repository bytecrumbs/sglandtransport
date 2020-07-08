import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/provider/asset_flare.dart';

class SliverView extends StatefulWidget {
  SliverView({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  _SliverViewState createState() => _SliverViewState();
}

class _SliverViewState extends State<SliverView> {
  bool _isExpanded = true;
  final double _animationHeight = 240.0;

  @override
  Widget build(BuildContext context) {
    final asset = AssetFlare(bundle: rootBundle, name: 'images/city.flr');

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {
        setState(() {
          _isExpanded = scrollState.metrics.pixels < _animationHeight / 1.5;
        });
        return false;
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                color: _isExpanded
                    ? Theme.of(context).primaryColorDark
                    : Colors.white,
              ),
            ),
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 240.0,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: _animationHeight,
                child: FlareActor.asset(
                  asset,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.cover,
                  animation: 'Loop',
                ),
              ),
            ),
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
