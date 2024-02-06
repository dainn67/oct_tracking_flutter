import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  final VoidCallback callback;

  const ConfirmDelete({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Action'),
      content: const Text('Are you sure you want to perform this action?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            callback();
            Navigator.pop(context);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
