import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class BusViewModel extends BaseViewModel {
  static final _log = Logger('DatabaseProvider');

  int _currentIndex = 0;

  final _tabItems = [
    TabItem(
      icon: Icons.location_searching,
      title: 'Nearby',
    ),
    TabItem(
      icon: Icons.favorite,
      title: 'Favorites',
    ),
    TabItem(
      icon: Icons.search,
      title: 'Search',
    ),
  ];

  int get currentIndex => _currentIndex;
  List<TabItem<IconData>> get tabItems => _tabItems;

  void onItemTapped(int index) {
    _currentIndex = index;
    _sendCurrentTabToAnalytics();
    notifyListeners();
  }

  void _sendCurrentTabToAnalytics() {
    _log.info('Implement _sendCurrentTabToAnalytics');
  }
}
