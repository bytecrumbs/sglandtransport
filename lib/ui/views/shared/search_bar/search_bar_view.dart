import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/utils/keyboard.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key key,
    this.controller,
    @required this.onSearchTextChanged,
    this.showCancel = true,
  }) : super(key: key);

  final Function(String) onSearchTextChanged;
  final TextEditingController controller;
  final bool showCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.search),
            title: _buildTextField(),
            trailing: showCancel ? _buildTrailingView(context) : null,
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
      onChanged: onSearchTextChanged,
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
