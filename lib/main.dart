import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts C A',
      theme: appTheme,
      home: const Scaffold(),
    );
  }
}
