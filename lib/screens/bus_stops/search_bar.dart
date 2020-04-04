import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Enter a Bus Stop number',
          icon: Icon(Icons.search),
          suffixIcon: Icon(Icons.clear),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
