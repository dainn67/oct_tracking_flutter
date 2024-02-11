import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDelete extends StatelessWidget {
  final VoidCallback callback;

  const ConfirmDelete({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('confirm_action'.tr),
      content: Text('delete_action'.tr),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('cancel'.tr),
        ),
        TextButton(
          onPressed: () {
            callback();
            Navigator.pop(context);
          },
          child: Text('confirm'.tr),
        ),
      ],
    );
  }
}
