import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeonDarkTheme {
  // 🔥 Dark Mode (Manly Neon)
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(153, 40, 40, 40), // Almost black
      primaryColor: const Color.fromRGBO(7, 171, 51, 0.981), // Neon green
      colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 90, 207, 40),
        secondary: Color.fromARGB(255, 35, 77, 229), // 
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.orbitron(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF00FF7F),
        ),
        bodyLarge: GoogleFonts.orbitron(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF00FF7F),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFF00FF7F),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // 💖 Light Mode (Girlypop Vibes)
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFF0F5), // Light pink (Lavender Blush)
      primaryColor: const Color(0xFFFFC0CB), // Baby Pink
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFFFC0CB), // Soft Pink
        secondary: Color(0xFFFF69B4), // Hot Pink
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.orbitron(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFF69B4), // Hot Pink
        ),
        bodyLarge: GoogleFonts.orbitron(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFFFC0CB), // Soft Pink
        titleTextStyle: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFFFF69B4), // Hot Pink
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
