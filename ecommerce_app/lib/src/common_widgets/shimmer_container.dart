import 'package:ecommerce_app/src/common_widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerContainer({super.key, this.height = 16.0, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ShimmerWidget(makeBottomCornerRounder: true),
    );
  }
}
