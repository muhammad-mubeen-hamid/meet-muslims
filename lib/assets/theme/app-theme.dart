import 'package:flutter/material.dart';
import 'package:meet_muslims_client/assets/theme/text-theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.deepPurple,
    textTheme: myTextTheme,
      errorColor: Colors.red.shade900,
      buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.deepOrangeAccent,
          secondary: Colors.deepOrangeAccent,
        )
      )
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
      textTheme: myTextTheme,
      errorColor: Colors.red.shade900,
      buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.dark(
        primary: Colors.deepOrangeAccent,
        secondary: Colors.deepOrangeAccent,
      )
    )
  );
}
