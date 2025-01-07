import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/common_widgets/shimmer_container.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';

class ShimmerReviewList extends StatelessWidget {
  const ShimmerReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => ResponsiveCenter(
          maxContentWidth: Breakpoint.tablet,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p16,
            vertical: Sizes.p8,
          ),
          child: ShimmerProductCard(),
        ),
        childCount: 2,
      ),
    );
  }
}

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerContainer(height: 20),
                ShimmerContainer(width: 60),
              ],
            ),
            gapH16,
            ShimmerContainer(width: double.infinity),
          ],
        ),
      ),
    );
  }
}
