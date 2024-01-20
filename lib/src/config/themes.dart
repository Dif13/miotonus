import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      //   appBarTheme: const AppBarTheme(
      //     elevation: 0.0,
      //     color: Colors.purple,
      //   ),
      scaffoldBackgroundColor: Colors.white,
      // primaryColor: Colors.red,
      // splashColor: Colors.transparent,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      useMaterial3: true,
    );
  }
}
