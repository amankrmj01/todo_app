import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

var lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(
          const Color.fromRGBO(253, 214, 93, 1),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          const Color.fromRGBO(97, 28, 134, 1),
        ),
      ),
    ),
    primaryColor: const Color(0xFF6200EE),
    primaryColorLight: const Color(0xFF3700B3),
    primaryColorDark: const Color(0xFF3700B3),
    hintColor: const Color(0xFF03DAC6),
    scaffoldBackgroundColor: const Color.fromRGBO(231, 226, 207, 1.0),
    cardColor: const Color(0xFFFFFFFF),
    dividerColor: const Color(0xFFBDBDBD),
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        // iconTheme: const IconThemeData(color: Color.fromRGBO(253, 214, 93, 1)),
        actionsIconTheme:
            const IconThemeData(color: Color.fromRGBO(253, 214, 93, 1)),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(255, 244, 228, 1.0),
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.black),
        titleSpacing: 20,
        backgroundColor: const Color.fromRGBO(97, 28, 134, 1),
        titleTextStyle: GoogleFonts.raleway().copyWith(
            color: const Color.fromRGBO(253, 214, 93, 1), fontSize: 24)),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(97, 28, 134, 1),
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
    colorScheme: const ColorScheme.light(
      secondary: Color.fromRGBO(253, 214, 93, 1),
      primary: Color.fromRGBO(97, 28, 134, 1),
      surface: Color.fromRGBO(255, 235, 211, 1.0),
      error: Color(0xFFB00020),
      onPrimary: Color.fromRGBO(120, 81, 169, 1),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFF000000),
      onError: Color(0xFFFFFFFF),
    ));
