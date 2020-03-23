import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals.dart';

class BusStops extends StatelessWidget {
  static const String id = 'bus_stops_screen';
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: const Text('434343'),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            Navigator.pushNamed(context, BusArrivals.id);
          },
        ),
        ListTile(
          title: const Text('234534'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('765675'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('456566'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('545543'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('345777'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('666555'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('334432'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('776543'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('443221'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('454323'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('987654'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('667865'),
          trailing: Icon(Icons.arrow_right),
        ),
        ListTile(
          title: const Text('454333'),
          trailing: Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}
