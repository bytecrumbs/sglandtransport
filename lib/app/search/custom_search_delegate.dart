import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'search_result_view.dart';

/// The Search function that extends the native Material search
class CustomSearchDelegate extends SearchDelegate<dynamic> {
  /// Firebase Analytics reference
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null, 'context cannot be null');
    final theme = Theme.of(context);
    assert(theme != null, 'Theme cannot be null');
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Color(0xB3FFFFFF)),
      ),
      primaryColor: theme.primaryColorDark,
      textTheme: theme.textTheme.copyWith(
        headline6: theme.textTheme.subtitle1.copyWith(color: Colors.white),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Search for bus stops';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          analytics.logSearch(
            searchTerm: query,
          );
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        analytics.logSearch(
          searchTerm: query,
        );
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultView(searchTerm: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchResultView(searchTerm: query);
  }
}
