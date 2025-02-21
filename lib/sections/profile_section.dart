import "package:flutter/material.dart";
import "package:new_game_app/database/creategame_table.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final userinfoDatabase = UserinfoDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          centerTitle: true,
        ),
        body: Center(
          child: Text(Supabase
              .instance.client.auth.currentUser?.userMetadata?['username']),
        ));
  }
}
