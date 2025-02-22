import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:new_game_app/database/creategame_table.dart";
import "package:new_game_app/database/database%20models/creategame_model.dart";
import "package:new_game_app/pages/game_info.dart";
import "package:new_game_app/pages/home_page.dart";
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

  final _editInvitedUsersController = TextEditingController();
  final _editGameNameController = TextEditingController();

  void createGame() {
    //Note: get values
    final gameName = _gameNameController.text;
    final invitedUsers = _invitedUsersController.text;

    if (gameName == "" || invitedUsers == "" && !publicGame) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all the fields")));
      return;
    }
    createGameTable.createGame(CreategameModel(
        game: gameName,
        creator: Supabase
            .instance.client.auth.currentUser?.userMetadata?['username'],
        creator_email: Supabase.instance.client.auth.currentUser?.email,
        invited_users: invitedUsers,
        public: publicGame));

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Game created successfully")));

    Navigator.pop(context); // pop current page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void deleteGame(gameId) async {
    await createGameTable.deleteGame(gameId);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Game deleted successfully")));

    Navigator.pop(context); // pop current page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void editGame(game) {
    _editGameNameController.text = game.game;
    _editInvitedUsersController.text = game.invited_users;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Edit Game: " + game.game),
              content: SizedBox(
                height: 115,
                child: Column(
                  children: [
                    TextField(
                      controller: _editGameNameController,
                      decoration: InputDecoration(
                        label: Text("Game Name"),
                      ),
                    ),
                    Visibility(
                      visible: !game.public,
                      child: TextField(
                        controller: _editInvitedUsersController,
                        decoration: InputDecoration(
                          label: Text("Invited Users"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      await createGameTable.updateGame(
                          game,
                          _editGameNameController.text,
                          _editInvitedUsersController.text);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.create)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel)),
              ],
            ));
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
              ElevatedButton(onPressed: createGame, child: Text("Create Game")),
              SizedBox(
                height: 30,
              ),
              Text(
                "My active games",
                style: TextStyle(fontSize: 20),
              ),
              StreamBuilder(
                  stream: createGameTable.streamGames,
                  builder: (context, snapshot) {
                    //Info: loading
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    //Info: loaded
                    final _games = snapshot.data!;

                    //Note: list of games
                    return Expanded(
                      child: ListView.builder(
                        itemCount: _games.length,
                        itemBuilder: (context, index) {
                          final game = _games[index];
                          if (game.creator_email !=
                              Supabase.instance.client.auth.currentUser?.email)
                            return SizedBox();
                          return ListTile(
                            title: Text(game.game),
                            subtitle: Text(game.creator),
                            leading: game.public
                                ? Icon(Icons.public)
                                : Icon(Icons.private_connectivity),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () => editGame(game),
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () => deleteGame(game.id),
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),
                            onTap: () {
                              //Note: Navigate to game page with game details
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GameInfo(
                                            gameCreator: game.creator,
                                            gameCreatorEmail:
                                                game.creator_email,
                                            gameInvitedUsers:
                                                game.invited_users,
                                            gameName: game.game,
                                            gamePublic: game.public,
                                          )));
                            },
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
