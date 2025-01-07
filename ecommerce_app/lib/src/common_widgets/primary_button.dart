import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:flutter/material.dart';

import 'custom_progress_indicator.dart';

class PrimaryButton extends StatelessWidget {
  /// Create a PrimaryButton.
  /// if [isLoading] or [isShowLoading] is true, a loading indicator will be displayed instead of
  /// the text.
  const PrimaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.isShowLoading = true,
    this.onPressed,
    this.buttonStyle,
  });

  final String text;
  final bool isLoading;
  final bool isShowLoading;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: (isLoading && isShowLoading)
          ? CustomProgressIndicator(color: context.colorScheme.onPrimary)
          : Text(text),
    );
  }
}
