import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/utils/keyboard.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key key,
    this.controller,
    @required this.onSearchTextChanged,
  }) : super(key: key);

  final Function(String) onSearchTextChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.search),
            title: _buildTextField(),
            trailing: _buildTrailingView(context),
          ),
        ),
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      key: const ValueKey<String>('searchInput'),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Search bus stop', border: InputBorder.none),
      controller: controller,
      onSubmitted: onSearchTextChanged,
    );
  }

  IconButton _buildTrailingView(BuildContext context) {
    return IconButton(
      key: const ValueKey<String>('clearSearchInput'),
      icon: Icon(Icons.cancel),
      onPressed: () {
        controller.clear();
        Keyboard.dismiss(context);
        onSearchTextChanged('');
      },
    );
  }
}
