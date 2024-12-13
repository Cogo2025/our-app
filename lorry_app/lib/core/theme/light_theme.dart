import 'package:flutter/material.dart';


final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.yellow,
  scaffoldBackgroundColor: Colors.yellow[100],
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black),

    titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
  ),
);
