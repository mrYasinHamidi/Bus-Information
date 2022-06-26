import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final Color? color;
  final double? size;

  const Dot({
    Key? key,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size??10,
      height: size??10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color??Colors.green,
      ),
    );
  }
}
