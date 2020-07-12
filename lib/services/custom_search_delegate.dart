import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  String get searchFieldLabel => 'Search for bus stops';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            'Showing a search result for \'${query}\'',
          ),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isNotEmpty
        ? Column(
            children: <Widget>[
              Text('Suggestion 1 for $query'),
              Text('Suggestion 2 for $query'),
            ],
          )
        : Column();
  }
}
