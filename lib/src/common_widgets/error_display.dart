import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    super.key,
    required this.message,
    this.onPressed,
  });

  final String message;
  final dynamic Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          if (onPressed != null)
            Column(
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Retry'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
