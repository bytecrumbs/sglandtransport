import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lta_datamall_flutter/utils/keyboard.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.controller,
    @required this.onSearchTextChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onSearchTextChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.search),
            title: TextField(
              key: const ValueKey<String>('searchInput'),
              keyboardType: TextInputType.text,
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Search bus stop', border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: IconButton(
              key: const ValueKey<String>('clearSearchInput'),
              icon: Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                Keyboard.dismiss(context);
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
