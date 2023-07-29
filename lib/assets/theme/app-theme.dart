import 'package:flutter/material.dart';
import 'package:meet_muslims_client/assets/theme/text-theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: Colors.red.shade200,
      textTheme: myTextTheme,
      errorColor: Colors.red.shade900,
      buttonTheme: const ButtonThemeData(
          colorScheme: ColorScheme.light(
            primary: Color.fromRGBO(38, 60, 243, 1.0),
            secondary: Color.fromRGBO(227, 226, 226, 1.0),
          ),
          height: 60.0),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
              color: Colors.black12, width: 1.0, style: BorderStyle.solid),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
              color: Colors.black12, width: 1.0, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
              color: Colors.black45, width: 2.0, style: BorderStyle.solid),
        ),
      ));

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.deepPurple,
      textTheme: myTextTheme,
      errorColor: Colors.red.shade900,
      buttonTheme: const ButtonThemeData(
          colorScheme: ColorScheme.dark(
        primary: Color.fromRGBO(0, 87, 26, 1.0),
        secondary: Colors.deepOrangeAccent,
      )));
}
