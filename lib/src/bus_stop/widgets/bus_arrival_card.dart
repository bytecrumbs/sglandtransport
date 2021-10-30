import 'package:flutter/material.dart';

import '../bus_repository.dart';

class BusArrivalCard extends StatelessWidget {
  const BusArrivalCard({
    Key? key,
    required this.busArrivalModel,
  }) : super(key: key);

  final BusArrivalDetailsModel busArrivalModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(busArrivalModel.serviceNo),
      ),
    );
  }
}
