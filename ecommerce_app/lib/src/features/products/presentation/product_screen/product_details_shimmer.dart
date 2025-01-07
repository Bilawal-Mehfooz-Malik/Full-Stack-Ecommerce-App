import 'package:ecommerce_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:ecommerce_app/src/common_widgets/shimmer_container.dart';
import 'package:ecommerce_app/src/common_widgets/shimmer_widget.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveTwoColumnLayout(
      startContent: StartContentSkeleton(),
      spacing: Sizes.p4,
      endContent: EndContentSkeleton(),
    );
  }
}

class StartContentSkeleton extends StatelessWidget {
  const StartContentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: AspectRatio(
          aspectRatio: 1,
          child: ShimmerWidget(makeBottomCornerRounder: true),
        ),
      ),
    );
  }
}

class EndContentSkeleton extends StatelessWidget {
  const EndContentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShimmerContainer(height: 22),
            gapH8,
            ShimmerContainer(height: 14),
            gapH8,
            ShimmerContainer(height: 20),
            gapH8,
            const Divider(),
            gapH8,
            ShimmerContainer(height: 22, width: 60),
            gapH8,
            const Divider(),
            gapH8,
            ResponsiveTwoColumnLayout(
              spacing: Sizes.p16,
              breakpoint: 300,
              startFlex: 3,
              endFlex: 2,
              rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
              rowCrossAxisAlignment: CrossAxisAlignment.center,
              columnCrossAxisAlignment: CrossAxisAlignment.center,
              startContent: ShimmerContainer(),
              endContent: ShimmerContainer(),
            ),
            gapH8,
            const Divider(),
            gapH8,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerContainer(height: 18, width: 80),
                ShimmerContainer(height: 30, width: 120),
              ],
            ),
            gapH8,
            const Divider(),
            gapH8,
            SizedBox(
              width: 150,
              height: Sizes.p48,
              child: ShimmerWidget(makeFullRounded: true),
            )
          ],
        ),
      ),
    );
  }
}
