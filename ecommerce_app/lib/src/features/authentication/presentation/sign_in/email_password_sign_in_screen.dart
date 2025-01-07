import 'package:ecommerce_app/src/common_widgets/custom_text_button.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_validators.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/themes/theme_extension.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Email & password sign in screen.
/// Wraps the [EmailPasswordSignInContents] widget below with a [Scaffold] and
/// [AppBar] with a title.
class EmailPasswordSignInScreen extends StatelessWidget {
  const EmailPasswordSignInScreen({super.key, required this.formType});
  final EmailPasswordSignInFormType formType;

  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign In'.hardcoded),
      ),
      body: EmailPasswordSignInContents(formType: formType),
    );
  }
}

/// A widget for email & password authentication, supporting the following:
/// - sign in
/// - register (create an account)
class EmailPasswordSignInContents extends ConsumerStatefulWidget {
  const EmailPasswordSignInContents({
    super.key,
    this.onSignedIn,
    required this.formType,
  });
  final VoidCallback? onSignedIn;

  /// The default form type to use.
  final EmailPasswordSignInFormType formType;
  @override
  ConsumerState<EmailPasswordSignInContents> createState() =>
      _EmailPasswordSignInContentsState();
}

class _EmailPasswordSignInContentsState
    extends ConsumerState<EmailPasswordSignInContents>
    with EmailAndPasswordValidators {
  var _submitted = false;
  bool _obscureText = true;
  bool _showClearButton = false;
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  // track the formType as a local state variable
  late var _formType = widget.formType;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _showClearButton = _emailController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    // only submit the form if validation passes
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(emailPasswordSignInControllerProvider.notifier);
      final success = await controller.submit(
        email: email,
        password: password,
        formType: _formType,
      );
      if (success) {
        widget.onSignedIn?.call();
      }
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType() {
    // * Toggle between register and sign in form
    setState(() => _formType = _formType.secondaryActionFormType);
    // * Clear the password field when doing so
    _passwordController.clear();
  }

  TextFormField _buildPasswordField(
    AsyncValue<void> state,
    BuildContext context,
  ) {
    return TextFormField(
      key: EmailPasswordSignInScreen.passwordKey,
      controller: _passwordController,
      decoration: InputDecoration(
        enabled: !state.isLoading,
        hintText: _formType.passwordLabelText,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: context.colorScheme.secondary,
          ),
          onPressed: () {
            setState(() => _obscureText = !_obscureText);
          },
        ),
      ),
      autocorrect: false,
      obscureText: _obscureText,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onEditingComplete: () => _passwordEditingComplete(),
      validator: (password) =>
          !_submitted ? null : passwordErrorText(password ?? '', _formType),
    );
  }

  TextFormField _buildEmailField(AsyncValue<void> state, BuildContext context) {
    return TextFormField(
      key: EmailPasswordSignInScreen.emailKey,
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Enter your email'.hardcoded,
        enabled: !state.isLoading,
        suffixIcon: _showClearButton
            ? IconButton(
                icon: Icon(Icons.clear, color: context.colorScheme.secondary),
                onPressed: () => _emailController.clear(),
              )
            : null,
      ),
      autocorrect: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onEditingComplete: () => _emailEditingComplete(),
      validator: (email) => !_submitted ? null : emailErrorText(email ?? ''),
      inputFormatters: <TextInputFormatter>[
        ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(emailPasswordSignInControllerProvider);
    return ResponsiveScrollableCard(
      child: FocusScope(
        node: _node,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Email'.hardcoded, style: context.textTheme.titleMedium),
              gapH8,
              _buildEmailField(state, context),
              gapH16,
              Text('Password'.hardcoded, style: context.textTheme.titleMedium),
              gapH8,
              _buildPasswordField(state, context),
              gapH16,
              PrimaryButton(
                text: _formType.primaryButtonText,
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : () => _submit(),
              ),
              gapH8,
              CustomTextButton(
                text: _formType.secondaryButtonText,
                onPressed: state.isLoading ? null : _updateFormType,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
