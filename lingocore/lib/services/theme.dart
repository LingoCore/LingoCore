

  import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

final darkThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: catppuccin.mocha.blue,
      onPrimary: catppuccin.mocha.base,
      secondary: catppuccin.mocha.sapphire,
      onSecondary: catppuccin.mocha.base,
      error: catppuccin.mocha.red,
      onError: catppuccin.mocha.base,
      surface: catppuccin.mocha.base,
      onSurface: catppuccin.mocha.text,
    ),
  );
  final lightThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: catppuccin.latte.blue,
      onPrimary: catppuccin.latte.base,
      secondary: catppuccin.latte.sapphire,
      onSecondary: catppuccin.latte.base,
      error: catppuccin.latte.red,
      onError: catppuccin.latte.base,
      surface: catppuccin.latte.base,
      onSurface: catppuccin.latte.text,
    ),
  );

  Flavor getFlavour(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark
      ? catppuccin.mocha
      : catppuccin.latte;
}
