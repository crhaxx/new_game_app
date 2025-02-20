import 'package:flutter/material.dart';
import 'package:new_game_app/pages/app_start.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppStart(),
    );
  }
}
