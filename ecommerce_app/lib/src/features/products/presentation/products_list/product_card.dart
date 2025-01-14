import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/products/presentation/product_screen/product_average_rating.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:ecommerce_app/src/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to show a single product inside a card.
class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product, this.onPressed});
  final Product product;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const productCardKey = Key('product-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceFormatted =
        ref.watch(currencyFormatterProvider).format(product.price);
    return Card(
      child: InkWell(
        key: productCardKey,
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomImage(imageUrl: product.imageUrl),
            gapH12,
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.p4,
                horizontal: Sizes.p12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: context.textTheme.titleMedium),
                  if (product.numRatings >= 1) ...[
                    gapH8,
                    ProductAverageRating(product: product),
                  ],
                  gapH8,
                  Text(priceFormatted, style: context.textTheme.titleLarge),
                  gapH4,
                  Text(
                    product.availableQuantity <= 0
                        ? 'Out of Stock'.hardcoded
                        : 'Quantity: ${product.availableQuantity}'.hardcoded,
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
