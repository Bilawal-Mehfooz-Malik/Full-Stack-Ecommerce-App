import 'package:ecommerce_app/src/common_widgets/decorated_box_with_shadow.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:ecommerce_app/src/common_widgets/shimmer_container.dart';
import 'package:ecommerce_app/src/common_widgets/shimmer_widget.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';

class ShimmerCartItemsBuilder extends StatelessWidget {
  final bool isPayment;
  const ShimmerCartItemsBuilder({super.key, this.isPayment = false});

  @override
  Widget build(BuildContext context) {
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    final screenWidth = MediaQuery.sizeOf(context).width;
    // * on wide layouts, show a list of items on the left and the checkout
    // * button on the right
    if (screenWidth >= Breakpoint.tablet) {
      return ResponsiveCenter(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Row(
          children: [
            Flexible(
              // use 30 flex units for the list of items
              flex: 30,
              child: ListView.builder(
                itemCount: 3,
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                itemBuilder: (context, index) =>
                    ShimmerCartItem(isPayment: isPayment),
              ),
            ),
            gapW16,
            Flexible(
              // use 11 flex unit for the checkout button
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                child: ShimmerCTATextWithBTN(),
              ),
            )
          ],
        ),
      );
    } else {
      // * on narrow layouts, show a [Column] with a scrollable list of items
      // * and a pinned box at the bottom with the checkout button
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              padding: const EdgeInsets.all(Sizes.p16),
              itemBuilder: (context, index) =>
                  ShimmerCartItem(isPayment: isPayment),
            ),
          ),
          DecoratedBoxWithShadow(child: ShimmerCTATextWithBTN()),
        ],
      );
    }
  }
}

class ShimmerCTATextWithBTN extends StatelessWidget {
  const ShimmerCTATextWithBTN({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerContainer(height: 28),
        gapH8,
        SizedBox(
          height: 48,
          child: ShimmerWidget(makeFullRounded: true),
        ),
        gapH8,
      ],
    );
  }
}

class ShimmerCartItem extends StatelessWidget {
  final bool isPayment;
  const ShimmerCartItem({super.key, this.isPayment = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: ShimmerCartItemContents(isPayment: isPayment),
        ),
      ),
    );
  }
}

/// Shows a shopping cart item for a given product
class ShimmerCartItemContents extends StatelessWidget {
  final bool isPayment;
  const ShimmerCartItemContents({super.key, this.isPayment = false});

  @override
  Widget build(BuildContext context) {
    return ResponsiveTwoColumnLayout(
      startFlex: 1,
      endFlex: 2,
      breakpoint: 320,
      startContent: AspectRatio(
        aspectRatio: 1,
        child: ShimmerWidget(makeBottomCornerRounder: true),
      ),
      spacing: Sizes.p16,
      endContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShimmerContainer(height: 22),
          gapH12,
          ShimmerContainer(height: 22),
          gapH12,
          isPayment
              ? ShimmerContainer(height: 16, width: 100)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerContainer(height: 30, width: 100),
                    gapW8,
                    ShimmerContainer(height: 30, width: 30),
                    const Spacer(),
                  ],
                ),
        ],
      ),
    );
  }
}
