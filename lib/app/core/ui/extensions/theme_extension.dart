import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
