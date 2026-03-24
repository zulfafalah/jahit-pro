import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home/home_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(
    const ProviderScope(
      child: JahitProApp(),
    ),
  );
}

class JahitProApp extends StatelessWidget {
  const JahitProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jahit Pro",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.surface,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.surface,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
