import 'package:Gamebuddy/sections/profile_section.dart';
import 'package:flutter/material.dart';

class GameInfo extends StatefulWidget {
  final gameName, gamePublic, gameCreator, gameCreatorEmail, gameInvitedUsers;
  const GameInfo(
      {super.key,
      required this.gameName,
      required this.gamePublic,
      required this.gameCreator,
      required this.gameCreatorEmail,
      required this.gameInvitedUsers});

  @override
  State<GameInfo> createState() => _GameInfoState();
}

class _GameInfoState extends State<GameInfo> {
  void goToProfile() {
    // Navigate to the profile page with the game creator's email
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSection(
          userEmail: widget.gameCreatorEmail,
          userName: widget.gameCreator,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text("About Game"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Game: ${widget.gameName}",
                      style: TextStyle(fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Game Type: ${widget.gamePublic ? "Public" : "Private"}",
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {
                    goToProfile();
                  },
                  child: Text(
                    "Creator: ${widget.gameCreator}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Text(
                  "Creator Email: ${widget.gameCreatorEmail}",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
