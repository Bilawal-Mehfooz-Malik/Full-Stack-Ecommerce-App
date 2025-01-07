import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';

/// Text button to be used as an [AppBar] action
class ActionTextButton extends StatelessWidget {
  const ActionTextButton({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: TextButton(
        style: ButtonStyle(
            foregroundColor:
                WidgetStatePropertyAll(context.colorScheme.onSurface)),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
