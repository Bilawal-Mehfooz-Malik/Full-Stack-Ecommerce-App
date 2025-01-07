import 'package:ecommerce_app/src/features/products/presentation/products_list/products_search_query_notifier.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Search field used to filter products by name
class ProductsSearchTextField extends ConsumerStatefulWidget {
  const ProductsSearchTextField({super.key});

  @override
  ConsumerState<ProductsSearchTextField> createState() =>
      _ProductsSearchTextFieldState();
}

class _ProductsSearchTextFieldState
    extends ConsumerState<ProductsSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearQuery() {
    _controller.clear();
    ref.read(productsSearchQueryNotifierProvider.notifier).setQuery('');
  }

  @override
  Widget build(BuildContext context) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          enabled: true,
          autofocus: false,
          style: context.textTheme.titleLarge,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colorScheme.inversePrimary,
            hintText: 'Search products'.hardcoded,
            prefixIcon:
                Icon(Icons.search, color: context.colorScheme.secondary),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: _clearQuery,
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onChanged: (text) => ref
              .read(productsSearchQueryNotifierProvider.notifier)
              .setQuery(text),
        );
      },
    );
  }
}
