// lib/presentation/themes/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      hintColor: Colors.blueAccent,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        elevation: 4,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
