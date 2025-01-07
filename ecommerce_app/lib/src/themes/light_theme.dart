import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lightThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: darkGreyColor,
      onSecondary: onPrimaryColor,
      inversePrimary: lightGreyColor,
    ),

    // scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: AppBarTheme(elevation: 0, surfaceTintColor: onPrimaryColor),

    /// [FilledButtonThemeData]
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryColor),
        foregroundColor: WidgetStatePropertyAll(onPrimaryColor),
        textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16)),
        fixedSize: WidgetStatePropertyAll(Size(double.infinity, Sizes.p48)),
      ),
    ),

    /// [TextButtonThemeData]
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(primaryColor),
        textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16)),
        fixedSize: WidgetStatePropertyAll(Size(double.infinity, Sizes.p48)),
      ),
    ),

    /// [InputDecorationTheme]
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkGreyColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkGreyColor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      labelStyle: TextStyle(fontSize: 16, color: darkGreyColor),
      hintStyle: TextStyle(fontSize: 16, color: darkGreyColor),
      floatingLabelStyle: TextStyle(fontSize: 16, color: primaryColor),
    ),

    /// [CardTheme]
    cardTheme: CardTheme(
      color: lightGreyColor,
      elevation: 2,
      surfaceTintColor: lightGreyColor,
    ),
    dividerTheme: DividerThemeData(color: dividerColor),
  );
});
