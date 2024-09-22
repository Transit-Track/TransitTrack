import 'package:flutter/material.dart';

class ForwardWidget extends StatelessWidget {
  final Color color;
  const ForwardWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: const Center(
          child: Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.white,
        size: 25,
      )),
    );
  }
}
