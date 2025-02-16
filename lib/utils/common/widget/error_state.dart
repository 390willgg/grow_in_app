import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/text_strings.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: onRetry,
          child: const Text(retry),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text(cancel),
        ),
      ],
    );
  }
}
