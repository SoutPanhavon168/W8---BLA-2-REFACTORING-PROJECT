import 'package:flutter/material.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: const Scaffold(body: HomeScreen()),
    );
  }
}
