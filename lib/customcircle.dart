import 'package:ecommerce_ui/globalcolours.dart';
import 'package:flutter/material.dart';

class Customcircle extends StatelessWidget {
  final width, height, borderwidth;
  final Color? color;
  const Customcircle(
      {required this.width,
      required this.height,
      this.color = Colors.transparent,
      this.borderwidth = 6.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.yellowAccent.withOpacity(0.6), width: borderwidth)),
    );
  }
}
