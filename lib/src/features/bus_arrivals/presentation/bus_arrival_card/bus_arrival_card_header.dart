import 'package:flutter/material.dart';

import '../../../../palette.dart';

class BusArrivalCardHeader extends StatelessWidget {
  const BusArrivalCardHeader({
    super.key,
    required this.serviceNo,
    required this.inService,
    this.destinationName,
  });

  final String serviceNo;
  final bool inService;
  final String? destinationName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            serviceNo,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ),
        if (inService)
          Container(
            margin: const EdgeInsets.only(left: 1),
            padding: const EdgeInsets.fromLTRB(7, 4, 10, 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.35),
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Text('to ${destinationName ?? ''}'),
          ),
      ],
    );
  }
}
