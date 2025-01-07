import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final bool makeBottomCornerRounder;
  final bool makeFullRounded;
  const ShimmerWidget({
    super.key,
    this.makeBottomCornerRounder = false,
    this.makeFullRounded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: ClipRRect(
        borderRadius: makeFullRounded
            ? BorderRadius.circular(Sizes.p24)
            : BorderRadius.only(
                topLeft: Radius.circular(Sizes.p12),
                topRight: Radius.circular(Sizes.p12),
                bottomLeft: makeBottomCornerRounder == true
                    ? Radius.circular(Sizes.p12)
                    : Radius.circular(0),
                bottomRight: makeBottomCornerRounder == true
                    ? Radius.circular(Sizes.p12)
                    : Radius.circular(0),
              ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: shimmerContainerColor,
        ),
      ),
    );
  }
}
