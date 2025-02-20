import "package:flutter/material.dart";
import "package:new_game_app/auth/auth_service.dart";

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final currentEmail = AuthService().getCurrentUserEmail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(currentEmail.toString()),
      ),
    );
  }
}
