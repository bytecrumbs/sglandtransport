import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/palette.dart';
import '../../../routing/app_router.dart';

class BusRouteTile extends StatelessWidget {
  const BusRouteTile({
    super.key,
    required this.busStopCode,
    required this.roadName,
    required this.description,
  });

  final String busStopCode;
  final String roadName;
  final String description;

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
              child: Container(
                color: kSecondaryColor,
                width: 4,
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
                const Icon(Icons.arrow_right),
              ],
            ),
          ),
        ],
      ),
    );
    // return Row(
    //   children: [
    //     Container(
    //       color: Colors.red,
    //       child: const Icon(Icons.route),
    //     ),
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(description),
    //         Text('$busStopCode | $roadName'),
    //         Text('$busStopCode | $roadName'),
    //         Text('$busStopCode | $roadName'),
    //       ],
    //     ),
    //   ],
    // );
  }
}
