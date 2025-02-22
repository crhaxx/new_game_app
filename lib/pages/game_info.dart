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
                      widget.gameName,
                      style: TextStyle(fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Creator: " +
                        widget.gameCreator +
                        "\n" +
                        "Creator Email: " +
                        widget.gameCreatorEmail,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
