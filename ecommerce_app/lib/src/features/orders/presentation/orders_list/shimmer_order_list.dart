import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/common_widgets/shimmer_container.dart';
import 'package:ecommerce_app/src/common_widgets/shimmer_widget.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class ShimmerOrderList extends StatelessWidget {
  const ShimmerOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => ResponsiveCenter(
              padding: const EdgeInsets.all(Sizes.p8),
              child: ShimmerOrderCard(),
            ),
            childCount: 3,
          ),
        ),
      ],
    );
  }
}

/// Shows all the details for a given order
class ShimmerOrderCard extends StatelessWidget {
  const ShimmerOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: context.colorScheme.secondary),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.p8)),
      ),
      child: Column(
        children: [
          ShimmerOrderHeader(),
          Divider(height: 1, color: context.colorScheme.secondary),
          ShimmerOrderItemsList(),
        ],
      ),
    );
  }
}

class ShimmerOrderHeader extends StatelessWidget {
  const ShimmerOrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.inversePrimary,
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerContainer(width: 80),
                  gapH4,
                  ShimmerContainer(width: 60),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ShimmerContainer(width: 40),
                  gapH4,
                  ShimmerContainer(width: 50),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerOrderItemsList extends StatelessWidget {
  const ShimmerOrderItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: ShimmerContainer(),
        ),
        ShimmerOrderItemListTile(),
      ],
    );
  }
}

class ShimmerOrderItemListTile extends StatelessWidget {
  const ShimmerOrderItemListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Sizes.p8,
        left: Sizes.p16,
        right: Sizes.p16,
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: ShimmerWidget(makeBottomCornerRounder: true),
            ),
          ),
          gapW8,
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(),
                gapH12,
                ShimmerContainer(height: 14, width: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
