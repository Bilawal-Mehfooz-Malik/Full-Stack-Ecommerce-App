import 'package:ecommerce_app/src/common_widgets/shimmer_container.dart';
import 'package:ecommerce_app/src/common_widgets/shimmer_widget.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(aspectRatio: 1, child: ShimmerWidget()),
          gapH12,
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.p4,
              horizontal: Sizes.p12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(),
                gapH8,
                ShimmerContainer(height: 20.0),
                gapH8,
                ShimmerContainer(height: 18.0, width: 100.0),
                gapH4,
                ShimmerContainer(height: 12.0, width: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
