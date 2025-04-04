import 'package:Gamebuddy/theme/theme.dart';
import 'package:Gamebuddy/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:Gamebuddy/database/auth/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
      anonKey: dotenv.env['anonKey'] ?? "", url: dotenv.env['url'] ?? "");
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
