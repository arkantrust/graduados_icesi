import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/src/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Graduados',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: palette,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
    );
  }
}

const ColorScheme palette = ColorScheme(
  primary: Color(0xFF0F4176), // Primary color
  primaryContainer: Color(0xFF0F4176), // Variant of the primary color
  secondary: Colors.green, // Secondary color (change as needed)
  secondaryContainer: Colors.greenAccent, // Variant of the secondary color
  surface: Colors.white, // Background color
  background: Colors.white, // Background color
  error: Colors.red, // Error color
  onPrimary: Colors.white, // Text color on primary color
  onSecondary: Colors.black, // Text color on secondary color
  onSurface: Colors.black87, // Text color on background
  onBackground: Colors.black87, // Text color on background
  onError: Colors.white, // Text color on error color
  brightness: Brightness.light, // Light or dark theme
);
