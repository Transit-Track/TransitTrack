import 'package:flutter/material.dart';
import 'package:transittrack/core/theme.dart';

class ButtonWidget extends StatelessWidget {
  final BuildContext context;
  final String text;
  final VoidCallback onClick;
  final Color color;
  final double width;
  final double height;

  const ButtonWidget(
      {super.key,
      required this.context,
      required this.text,
      required this.onClick,
      this.color = primary,
      this.width = 128,
      this.height = 43
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(100))),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
