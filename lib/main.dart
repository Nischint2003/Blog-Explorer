import 'package:blog_explorer/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(scaffoldBackgroundColor: Colors.white),
      home: const HomePage(),
    );
  }
}