import 'package:ecommerce_app/src/common_widgets/action_text_button.dart';
import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/common_widgets/custom_progress_indicator.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_contents.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Simple account screen showing some user info and a logout button.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  void _logout(BuildContext context, WidgetRef ref) async {
    final logout = await showAlertDialog(
      context: context,
      title: 'Are you sure?'.hardcoded,
      cancelActionText: 'Cancel'.hardcoded,
      defaultActionText: 'Logout'.hardcoded,
    );
    if (logout == true) {
      ref.read(accountScreenControllerProvider.notifier).signOut();
    }
  }

  Widget _buildBlurredLoadingIndicator(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black.withOpacity(0.6)),
        Center(child: CustomProgressIndicator()),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(accountScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Account'.hardcoded),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: state.isLoading ? null : () => context.pop(),
        ),
        actions: [
          ActionTextButton(
            text: 'Logout'.hardcoded,
            onPressed: state.isLoading ? null : () => _logout(context, ref),
          ),
        ],
      ),
      body: Stack(
        children: [
          const ResponsiveScrollableCard(child: AccountScreenContents()),
          if (state.isLoading) _buildBlurredLoadingIndicator(context),
        ],
      ),
    );
  }
}
