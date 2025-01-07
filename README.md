# Full Stack Ecommerce App

![eCommerce App Preview](/.github/images/ecommerce-app-preview.png)

## Setup
To clone the repo for the first time and open it in VSCode, run this:

```
git clone https://github.com/Bilawal-Mehfooz-Malik/Full-Stack-Ecommerce-App.git
```

### Firebase Setup

Since the project uses Firebase, some additional files will be needed:

```
lib/firebase_options.dart
ios/Runner/GoogleService-Info.plist
ios/firebase_app_id_file.json
macos/Runner/GoogleService-Info.plist
macos/firebase_app_id_file.json
android/app/google-services.json
```

These files have been added to `.gitignore`, so you need to run this command to generate them with the flutterfire CLI:

```
cd ecommerce_app
flutterfire configure
```

To ensure the Firebase rules and cloud functions are deployed, run:

```
firebase deploy
```

### Stripe Setup
For the Stripe code to work, a `STRIPE_PUBLISHABLE_KEY` needs to be set on the client.

To set it, create an `.env` file inside the `ecommerce_app` folder and add your [Stripe publishable key](https://dashboard.stripe.com/test/apikeys):

```bash
# ecommerce_app/.env
STRIPE_PUBLISHABLE_KEY=pk_test_YOUR_STRIPE_PUBLISHABLE_KEY
```

Then, run the generator:

```bash
dart run build_runner build -d
```

This will generate an `env.g.dart` file inside `lib`.

As a result, the API key can be read as `Env.stripePublishableKey` in the Stripe setup code.

> [!NOTE]
> API keys defined with `--dart-define-from-file` were failing to load on Flutter web in release mode (see [this answer](https://stackoverflow.com/a/65647968/436422) and [this comment](https://stackoverflow.com/questions/65647090/access-dart-define-environment-variables-inside-index-html#comment120444154_65647968)). To work around that, the project now uses the [Envied](https://pub.dev/packages/envied) package.