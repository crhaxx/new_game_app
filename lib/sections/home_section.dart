import "package:flutter/material.dart";
import "package:new_game_app/components/drawer_component.dart";
import "package:new_game_app/database/auth/auth_service.dart";
import "package:new_game_app/database/creategame_table.dart";
import "package:new_game_app/sections/profile_section.dart";

class InvitesPage extends StatefulWidget {
  const InvitesPage({super.key});

  @override
  State<InvitesPage> createState() => _InvitesPageState();
}

class _InvitesPageState extends State<InvitesPage> {
  final createGameTable = CreategameTable();
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
        title: Text("Home"),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: logout),
          IconButton(icon: Icon(Icons.person), onPressed: profile)
        ],
      ),
      body: StreamBuilder(
          stream: createGameTable.streamGames,
          builder: (context, snapshot) {
            //Info: loading
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            //Info: loaded
            final _games = snapshot.data!;

            //Note: list of games
            return ListView.builder(
              itemCount: _games.length,
              itemBuilder: (context, index) {
                final game = _games[index];
                return ListTile(
                  title: Text(game.game),
                  subtitle: Text(game.creator),
                  onTap: () {
                    //Note: Navigate to game page with game details
                  },
                );
              },
            );
          }),
      drawer: MyDrawer(),
    );
  }
}
