import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:lta_datamall_flutter/ui/views/shared/search_bar/search_bar_view.dart';

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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._container);
  final Container _container;

  @override
  double get minExtent => 100;

  @override
  double get maxExtent => 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _container,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}

class _SliverViewState extends State<SliverView> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final _animationHeight = screenHeight * 0.33;
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
            iconTheme: IconThemeData(
              color: _isExpanded
                  ? Theme.of(context).primaryColorDark
                  : Colors.white,
            ),
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
            expandedHeight: _animationHeight,
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
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              Container(
                height: 100,
                color: _isExpanded
                    ? Color.fromRGBO(0, 0, 0, 0)
                    : Color.fromRGBO(150, 156, 174, 1),
                child: SearchBar(
                  onSearchTextChanged: null,
                  showCancel: false,
                ),
              ),
            ),
            pinned: true,
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
