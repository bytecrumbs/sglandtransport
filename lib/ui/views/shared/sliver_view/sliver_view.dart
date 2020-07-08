import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/provider/asset_flare.dart';

class SliverView extends StatelessWidget {
  const SliverView({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final asset = AssetFlare(bundle: rootBundle, name: 'images/city.flr');

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(title),
          pinned: true,
          floating: false,
          snap: false,
          expandedHeight: 240.0,
          backgroundColor: Theme.of(context).primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              height: 320,
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
            [child],
          ),
        ),
      ],
    );
  }
}
