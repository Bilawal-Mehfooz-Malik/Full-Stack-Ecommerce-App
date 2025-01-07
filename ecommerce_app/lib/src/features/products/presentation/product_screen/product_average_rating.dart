import 'package:ecommerce_app/src/themes/colors.dart';
import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

/// Shows the product average rating score and the number of ratings
class ProductAverageRating extends StatelessWidget {
  const ProductAverageRating({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: ratingColor, size: 20),
        gapW8,
        Text(
          product.avgRating.toStringAsFixed(1),
          style: context.textTheme.bodyLarge,
        ),
        gapW8,
        Expanded(
          child: Text(
            product.numRatings == 1
                ? '1 rating'
                : '${product.numRatings} ratings',
            style: context.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
