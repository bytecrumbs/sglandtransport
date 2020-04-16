import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({
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
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Enter a bus stop number',
                  border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
