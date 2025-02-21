import 'package:flutter/material.dart';
import 'package:new_game_app/database/auth/auth_service.dart';
import 'package:new_game_app/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Note: Get auth service
  final authService = AuthService();

  //Note: text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //Note: Login button pressed
  void login() async {
    //Note: Prepare data
    final email = _emailController.text;
    final password = _passwordController.text;

    //Note: Try to login
    try {
      await authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          //Note: Email
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),

          //Note: Password
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),

          SizedBox(
            height: 12,
          ),

          //Note: Login button
          ElevatedButton(
            onPressed: login,
            child: const Text("Login"),
          ),

          SizedBox(
            height: 12,
          ),

          GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage())),
              child: Center(child: Text("Don't have an account? Sign Up")))
        ],
      ),
    );
  }
}
