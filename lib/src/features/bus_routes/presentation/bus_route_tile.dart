import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/palette.dart';
import '../../../routing/app_router.dart';

enum BusSequenceType {
  start,
  middle,
  end,
}

class BusRouteTile extends StatelessWidget {
  const BusRouteTile({
    super.key,
    required this.busStopCode,
    required this.roadName,
    required this.description,
    required this.busSequenceType,
  });

  final String busStopCode;
  final String roadName;
  final String description;
  final BusSequenceType busSequenceType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pop();
        GoRouter.of(context).goNamed(
          AppRoute.busArrivals.name,
          params: {
            'busStopCode': busStopCode,
          },
        );
      },
      child: Stack(
        children: [
          Positioned.fill(
            left: 13,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: busSequenceType == BusSequenceType.start
                          ? Colors.white
                          : kSecondaryColor,
                      width: 4,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: busSequenceType == BusSequenceType.end
                          ? Colors.white
                          : kSecondaryColor,
                      width: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            left: 8,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 14,
                width: 14,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('$busStopCode | $roadName'),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
