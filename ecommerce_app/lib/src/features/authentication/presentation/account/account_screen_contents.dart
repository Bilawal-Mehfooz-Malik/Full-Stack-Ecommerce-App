// Simple user data table showing the uid and email
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../themes/theme_extension.dart';
import '../../data/auth_repository.dart';
import 'email_verification_widget.dart';

class AccountScreenContents extends ConsumerWidget {
  const AccountScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    if (user == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!user.emailVerified) ...[
          Text(
            'Verify Your Email'.hardcoded,
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          gapH12,
          Text(
            'Please verify your email to unlock all features.'.hardcoded,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          gapH32,
        ],
        Text(
          user.email ?? '',
          style: context.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        gapH16,
        EmailVerificationWidget(user: user),
      ],
    );
  }
}
