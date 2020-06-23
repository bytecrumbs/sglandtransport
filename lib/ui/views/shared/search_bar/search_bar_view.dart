import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  SearchBar({
    Key key,
    @required this.onSearchTextChanged,
  }) : super(key: key);

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

class Keyboard {
  static void dismiss(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
