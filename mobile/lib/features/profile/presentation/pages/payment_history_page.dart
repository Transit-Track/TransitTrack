import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            0.5),
        backgroundColor: Colors.white,
        onPressed: () => (context).goNamed(AppPath.profile),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
