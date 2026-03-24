import 'package:flutter/material.dart';

import 'package:test_dart/widgets/expenses.dart';
import 'package:test_dart/theme.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  final materialTheme = MaterialTheme(
    ThemeData(useMaterial3: true).textTheme,
  );

  
  runApp(
    MaterialApp(
      darkTheme: materialTheme.dark().copyWith(
        cardTheme: const CardThemeData().copyWith(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),

      theme: materialTheme.light().copyWith(
        cardTheme: const CardThemeData().copyWith(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      // themeMode: ThemeMode.system, // default
      home: const Expenses(),
    ),
  );
}