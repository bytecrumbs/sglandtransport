import 'package:flutter/material.dart';

/// Shows a generic error message
class ErrorView extends StatelessWidget {
  /// The default constructor of the class
  const ErrorView({
    Key? key,
    @required this.message,
  })  : assert(message != null, 'A non-null String must be provided'),
        super(key: key);

  /// The detailed error message that should be shown
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Oops, something unexpected happened!'),
          Text(message),
        ],
      ),
    );
  }
}
