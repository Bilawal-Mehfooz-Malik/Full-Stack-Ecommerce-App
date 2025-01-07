import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../localization/string_hardcoded.dart';
import '../../../../themes/theme_extension.dart';
import '../../domain/app_user.dart';
import 'account_screen_controller.dart';

class EmailVerificationWidget extends ConsumerWidget {
  const EmailVerificationWidget({super.key, required this.user});
  final AppUser user;

  void _sendEmailVerification(WidgetRef ref, BuildContext context) async {
    final success = await ref
        .read(accountScreenControllerProvider.notifier)
        .sendEmailVerification(user);
    if (success && context.mounted) {
      showAlertDialog(
        context: context,
        title: 'Sent - now check your email'.hardcoded,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountScreenControllerProvider);
    if (user.emailVerified == false) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(
            isShowLoading: false,
            isLoading: state.isLoading,
            text: 'Verify email'.hardcoded,
            onPressed: () => _sendEmailVerification(ref, context),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verified'.hardcoded,
            style: context.textTheme.bodyLarge!.copyWith(color: greenColor),
          ),
          gapW8,
          Icon(Icons.check_circle, color: greenColor),
        ],
      );
    }
  }
}
