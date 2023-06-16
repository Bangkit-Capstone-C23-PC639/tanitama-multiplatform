import 'package:flutter/material.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/styles/text_theme.dart';

final themeData = ThemeData(
    primaryColor: primaryColor,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: textColor,
      primary: primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme);
