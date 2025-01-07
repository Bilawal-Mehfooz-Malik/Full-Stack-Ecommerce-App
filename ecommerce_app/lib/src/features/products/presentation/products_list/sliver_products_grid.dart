import 'dart:math';

import 'package:ecommerce_app/src/common_widgets/error_message_widget.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/constants/breakpoints.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/product_card.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_search_query_notifier.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/shimmer_product_card.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// A widget that displays the list of products that match the search query.
class SliverProductsGrid extends ConsumerWidget {
  const SliverProductsGrid({super.key, this.onPressed});
  final void Function(BuildContext, ProductID)? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Use the new search results provider
    final productsListValue = ref.watch(productsSearchResultsProvider);
    final error = productsListValue.error;
    if (error != null) {
      return SliverFillRemaining(
        child: Center(child: ErrorMessageWidget(error.toString())),
      );
    }
    // * The previous value will be returned while loading
    final products = productsListValue.value;
    // * As a result, we only show the loading indicator if the value is null
    if (products == null) {
      return SliverProductsAlignedGrid(
        itemCount: 8,
        itemBuilder: (_, __) => const ShimmerProductCard(),
      );
    }
    // * Otherwise, we use the current or previous value to show the products
    return SliverProductsAlignedGrid(
      itemCount: products.length,
      itemBuilder: (_, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onPressed: () => onPressed?.call(context, product.id),
        );
      },
    );
  }
}

class SliverProductsAlignedGrid extends StatelessWidget {
  const SliverProductsAlignedGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            'No products found'.hardcoded,
            style: context.textTheme.bodyLarge,
          ),
        ),
      );
    }
    // use a LayoutBuilder to determine the crossAxisCount
    return SliverLayoutBuilder(builder: (context, constraints) {
      // width of the screen
      final width = constraints.crossAxisExtent;
      // max width allowed for the sliver
      final maxWidth = min(width, Breakpoint.desktop);
      // use 1 column for width < 400px
      // then add one more column for each 200px
      final crossAxisCount = max(1, maxWidth ~/ 200);
      // calculate a "responsive" padding that increases
      // when the width is greater than the desktop breakpoint
      // this is used to center the content horizontally on large screens
      final padding = width > Breakpoint.desktop + Sizes.p32
          ? (width - Breakpoint.desktop) / 2
          : Sizes.p16;
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: Sizes.p16),
        sliver: SliverAlignedGrid.count(
          crossAxisCount: crossAxisCount,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
        ),
      );
    });
  }
}
