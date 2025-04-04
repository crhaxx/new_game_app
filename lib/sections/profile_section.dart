import "package:Gamebuddy/database/creategame_table.dart";
import "package:Gamebuddy/pages/game_info.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class ProfileSection extends StatefulWidget {
  final userName, userEmail;
  const ProfileSection(
      {super.key, required this.userName, required this.userEmail});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final createGameTable = CreategameTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.userName}'s profile"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/user.png",
                width: 125,
                height: 125,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 10),
              Text(
                "${widget.userName}",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                /* "${Supabase.instance.client.auth.currentUser?.userMetadata?['email']}" */ '${widget.userEmail}',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: 10),
              TextField(
                enabled: false,
              ),
              SizedBox(height: 25),
              Text(
                "Active games",
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
                          if (game.creator_email != widget.userEmail) {
                            return SizedBox();
                          }
                          return ListTile(
                            title: Text(game.game),
                            subtitle: Text(game.creator),
                            leading: game.public
                                ? Icon(Icons.public)
                                : Icon(Icons.private_connectivity),
                            trailing: SizedBox(
                              width: 100,
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
