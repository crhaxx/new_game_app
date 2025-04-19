import "package:Gamebuddy/components/no_internet_widget.dart";
import "package:Gamebuddy/noti_service.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:Gamebuddy/database/creategame_table.dart";
import "package:Gamebuddy/database/database%20models/creategame_model.dart";
import "package:Gamebuddy/pages/game_info.dart";
import "package:Gamebuddy/pages/home_page.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import 'package:http/http.dart' as http;
import 'dart:convert'; // <- tohle je důležité pro práci s JSON

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

  String invitedusersid = '';

  Future getUserId() async {
    await dotenv.load(fileName: '.env');
    final url = Uri.parse(
        'https://gjsjrcbshgkaviwdtxnn.supabase.co/auth/v1/admin/users');
    final serviceRoleKey = dotenv.env['service_role']!;

    final response = await http.get(
      url,
      headers: {
        'apikey': serviceRoleKey,
        'Authorization': 'Bearer $serviceRoleKey',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      final users = data['users'] as List<dynamic>;
      final user = users.firstWhere(
        (u) => u['email'] == 'nikola.crhak@gmail.com',
        orElse: () => null,
      );

      if (user != null) {
        print('ID uživatele: ${user['id']}');
        invitedusersid = user['id'] +
            ',ed97283e-b3be-4084-bfe2-681024d24e9f' +
            ',9b745908-5600-4dfb-9be8-69813269d7ee';
      } else {
        print('Uživatel s daným emailem nebyl nalezen.');
      }
    } else {
      print("Error: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }

  void createGame() async {
    // //Note: show notification
    // NotiService().showNotification(title: 'Title', body: 'body');

    //Note: get values
    final gameName = _gameNameController.text;
    final invitedUsers = _invitedUsersController.text;

    String listUsers = invitedUsers.trim();
    var users = (listUsers.split(','));

    int counter = 0;
    do {
      print(users[counter]);

      Supabase.instance.client.auth.getUser();
      counter++;
    } while (counter < users.length);

    if (gameName == "" || invitedUsers == "" && !publicGame) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all the fields")));
      return;
    }

    await getUserId();

    createGameTable.createGame(CreategameModel(
        game: gameName,
        creator: Supabase
            .instance.client.auth.currentUser?.userMetadata?['username'],
        creator_email: Supabase.instance.client.auth.currentUser?.email,
        invited_users: invitedusersid, //invitedUsers
        public: publicGame,
        creator_id: Supabase.instance.client.auth.currentUser!.id));

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
              ElevatedButton(
                onPressed: createGame,
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.inverseSurface)),
                child: Text(
                  "Create Game",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                ),
              ),
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
                      return NoInternetWidget();
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
