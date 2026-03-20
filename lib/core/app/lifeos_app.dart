import 'package:flutter/material.dart';
import 'package:life_os/features/dashboard/presentation/lifeos_shell.dart';

class LifeOsApp extends StatelessWidget {
  const LifeOsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE8383C),
          secondary: Color(0xFF2AC3DE),
          surface: Color(0xFF161B22),
        ),
        useMaterial3: true,
        fontFamily: 'monospace',
      ),
      home: const LifeOsShell(),
    );
  }
}
