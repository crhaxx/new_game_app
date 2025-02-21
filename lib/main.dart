import 'package:flutter/material.dart';
import 'package:new_game_app/database/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdqc2pyY2JzaGdrYXZpd2R0eG5uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAwNzc4NzMsImV4cCI6MjA1NTY1Mzg3M30._LYAarCghY5e3WCD5O8CSZYUpY13OaE5MY1qdE5CO9M",
      url: "https://gjsjrcbshgkaviwdtxnn.supabase.co");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
