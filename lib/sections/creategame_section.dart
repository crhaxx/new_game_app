import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:new_game_app/database/creategame_table.dart";
import "package:new_game_app/database/database%20models/creategame_model.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class CreategamePage extends StatefulWidget {
  const CreategamePage({super.key});

  @override
  State<CreategamePage> createState() => _CreategamePageState();
}

class _CreategamePageState extends State<CreategamePage> {
  final createGameTable = CreategameTable();

  bool publicGame = false;

  //Note: text controllers
  final _gameNameController = TextEditingController();
  final _invitedUsersController = TextEditingController();

  void createGame() {
    //Note: get values
    final gameName = _gameNameController.text;
    final invitedUsers = _invitedUsersController.text;

    createGameTable.createGame(CreategameModel(
        game: gameName,
        creator: Supabase
            .instance.client.auth.currentUser?.userMetadata?['username'],
        creator_email: Supabase.instance.client.auth.currentUser?.email,
        invited_users: invitedUsers,
        public: publicGame));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Game"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              TextField(
                controller: _gameNameController,
                decoration: InputDecoration(
                    labelText: "Game Name", prefixIcon: Icon(Icons.games)),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: !publicGame,
                child: TextField(
                  controller: _invitedUsersController,
                  decoration: InputDecoration(
                      labelText: "Invite Users", prefixIcon: Icon(Icons.mail)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Everyone can join the game"),
                  SizedBox(
                    width: 20,
                  ),
                  CupertinoSwitch(
                      value: publicGame,
                      onChanged: (value) {
                        setState(() {
                          publicGame = value;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: createGame, child: Text("Create Game"))
            ],
          ),
        ),
      ),
    );
  }
}
