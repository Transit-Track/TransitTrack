import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String? qrCodeBase64;

  const SuccessDialog({super.key, this.qrCodeBase64});

  @override
  Widget build(BuildContext context) {
    Uint8List? qrCodeImageBytes;

    if (qrCodeBase64 != null) {
      // Decode the Base64 string into bytes
      qrCodeImageBytes = base64Decode(qrCodeBase64!);
    }

    return AlertDialog(
      title: const Text('Payment Successful'),
      content: qrCodeImageBytes != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Here is your QR Code:'),
                const SizedBox(height: 10),
                Image.memory(qrCodeImageBytes), // Display the QR code image
              ],
            )
          : const Text('QR code not available'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
