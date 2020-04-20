import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.controller,
    @required this.onSearchTextChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onSearchTextChanged;

  void dismissFocus(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

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
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
              ],
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
                dismissFocus(context);
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
