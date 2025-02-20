import 'package:flutter/material.dart';
import 'package:new_game_app/auth/auth_service.dart';
import 'package:new_game_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Note: Get auth service
  final authService = AuthService();

  //Note: text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //Note: Sign Up button pressed
  void signUp() async {
    //Note: Prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    //Note: Check if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords don't match")));
      return;
    }

    //Note: Try to sign up
    try {
      await authService.signUpWithEmailAndPassword(email, password);

      Navigator.pop(context);
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
        title: Text("Sign Up"),
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

          //Note: Confirm password
          TextField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(labelText: "Confirm Password"),
            obscureText: true,
          ),

          SizedBox(
            height: 12,
          ),

          //Note: Sign Up button
          ElevatedButton(
            onPressed: signUp,
            child: const Text("Sign Up"),
          ),

          SizedBox(
            height: 12,
          ),

          GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage())),
              child: Center(child: Text("Have an account? Login")))
        ],
      ),
    );
  }
}
