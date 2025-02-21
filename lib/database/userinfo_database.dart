import 'package:new_game_app/database/database%20models/userinfo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserinfoDatabase {
  //Info: Database -> profiles
  final database = Supabase.instance.client.from('profiles');

  final streamPlaylists = Supabase.instance.client
      .from('playlists')
      .stream(primaryKey: [
    'id'
  ]).map((data) => data.map((userinfo) => Userinfo.fromMap(userinfo)).toList());
}
