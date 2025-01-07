import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? size;

  const CustomProgressIndicator({
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(color: color),
    );
  }
}
