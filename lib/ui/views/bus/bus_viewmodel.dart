import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:stacked/stacked.dart';

class BusViewModel extends BaseViewModel {
  final _analyticsObserver =
      locator<FirebaseAnalyticsService>().analyticsObserver;

  int _currentIndex = 0;

  final _tabItems = [
    TabItem(
      icon: Icons.location_searching,
      title: 'Nearby',
    ),
    TabItem(
      icon: Icons.favorite,
      title: 'Favorites',
    )
  ];

  int get currentIndex => _currentIndex;
  List<TabItem<IconData>> get tabItems => _tabItems;

  void onItemTapped(int index) {
    var longScreenName = 'Bus${_tabItems[index].title}';
    _currentIndex = index;
    _sendCurrentTabToAnalytics(longScreenName);
    notifyListeners();
  }

  void _sendCurrentTabToAnalytics(String screenName) {
    _analyticsObserver.analytics.setCurrentScreen(screenName: screenName);
  }
}
