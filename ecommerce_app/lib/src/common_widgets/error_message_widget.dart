import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:flutter/material.dart';

/// Reusable error message widget (just a [Text] with a red color).
class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {super.key});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: context.textTheme.bodyLarge!.copyWith(color: Colors.red),
    );
  }
}
