import 'package:flutter/material.dart';
import 'package:new_game_app/auth/auth_service.dart';
import 'package:new_game_app/sections/creategame_section.dart';
import 'package:new_game_app/sections/invites_section.dart';
import 'package:new_game_app/sections/profile_section.dart';
import 'package:new_game_app/sections/setting_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    InvitesPage(),
    CreategamePage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    //Note: Get auth service
    final authService = AuthService();

    //Note: Logout
    void logout() async {
      await authService.signOut();
    }

    void profile() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileSection()));
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: logout),
          IconButton(icon: Icon(Icons.person), onPressed: profile)
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_label),
            label: 'Create Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
