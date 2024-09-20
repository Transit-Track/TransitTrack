import 'package:flutter/material.dart';

class PinDialog extends StatelessWidget {
  final TextEditingController pinController;
  final VoidCallback onConfirm;

  const PinDialog({
    super.key,
    required this.pinController,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text("Enter PIN"),
      content: TextFormField(
        controller: pinController,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        decoration: const InputDecoration(
          hintText: 'Enter your 4-digit PIN',
          border: OutlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onConfirm,
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}
