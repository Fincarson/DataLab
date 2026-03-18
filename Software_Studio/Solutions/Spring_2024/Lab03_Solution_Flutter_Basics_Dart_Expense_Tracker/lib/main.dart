import 'package:flutter/material.dart';

import 'package:test_dart/widgets/expenses.dart';

// var kColorScheme = ColorScheme.fromSeed(
//   seedColor: const Color.fromARGB(255, 96, 59, 181),
// );

// var kDarkColorScheme = ColorScheme.fromSeed(
//   brightness: Brightness.dark,
//   seedColor: const Color.fromARGB(255, 5, 99, 125),
// );


// void main() {
//   runApp(
//     MaterialApp(
//       // Dark Theme
//       darkTheme: ThemeData.dark().copyWith(
//         colorScheme: kDarkColorScheme,
//         cardTheme: const CardThemeData().copyWith(
//           color: kDarkColorScheme.secondaryContainer,
//           margin: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 8,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: kDarkColorScheme.primaryContainer,
//             foregroundColor: kDarkColorScheme.onPrimaryContainer,
//           ),
//         ),
//       ),

//       // Light Theme
//       theme: ThemeData().copyWith(
//         colorScheme: kColorScheme,
//         appBarTheme: const AppBarTheme().copyWith(
//           backgroundColor: kColorScheme.onPrimaryContainer,
//           foregroundColor: kColorScheme.primaryContainer,
//         ),
//         cardTheme: const CardThemeData().copyWith(
//           color: kColorScheme.secondaryContainer,
//           margin: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 8,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: kColorScheme.primaryContainer,
//           ),
//         ),
//         textTheme: ThemeData().textTheme.copyWith(
//               titleLarge: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: kColorScheme.onSecondaryContainer,
//                 fontSize: 16,
//               ),
//             ),
//       ),
//       // themeMode: ThemeMode.system, // default
//       home: const Expenses(),
//     ),
//   );
// }

// Light Theme
final ColorScheme kLightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF7E57C2),
  brightness: Brightness.light,
);

// Dark Theme
final ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF7E57C2),
  brightness: Brightness.dark,
);

void main() {runApp(const ExpenseTrackerApp());}

class ExpenseTrackerApp extends StatelessWidget{
  const ExpenseTrackerApp({super.key});

  // Light Theme
  ThemeData lightTheme(){
    return ThemeData(
      useMaterial3: true,
      colorScheme: kLightColorScheme,
    ).copyWith(
      scaffoldBackgroundColor: const Color(0xFFF3EFF4),
      appBarTheme: AppBarTheme(
        backgroundColor: kLightColorScheme.primary,
        foregroundColor: kLightColorScheme.onPrimary,
      ),
      
      cardTheme: const CardThemeData().copyWith(
        color: kLightColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kLightColorScheme.primaryContainer,
          foregroundColor: kLightColorScheme.onPrimaryContainer,
        ),
      ),
      
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kLightColorScheme.onSecondaryContainer,
          fontSize: 16,
        ),
      ),
    );
  }

  // Dark Theme
  ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
    ).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: kDarkColorScheme.primary,
        foregroundColor: kDarkColorScheme.onPrimary,
      ),

      cardTheme: const CardThemeData().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kDarkColorScheme.onSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
      ),

      textTheme: ThemeData.dark().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kDarkColorScheme.onSecondaryContainer,
          fontSize: 16, 
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      darkTheme: darkTheme(),
      theme: lightTheme(),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    );
  }
}