import 'package:new_game_app/database/database%20models/creategame_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreategameTable {
  //Info: Database -> playlists
  final database = Supabase.instance.client.from('active_games');

  //Note: Create
  Future createGame(CreategameModel gameModel) async {
    await database.insert(gameModel.toMap());
  }

//Note: Read
  final streamGames = Supabase.instance.client
      .from('active_games')
      .stream(primaryKey: ['id']).map((data) => data
          .map((gameModelMap) => CreategameModel.fromMap(gameModelMap))
          .toList());

  //Note: Update
  Future updateGame(CreategameModel oldGameModel, String newGameModel) async {
    await database.update({
      'game': newGameModel,
    }).eq('id', oldGameModel.id!);
  }

  //Note: Delete
  Future deleteGame(CreategameModel gameModel) async {
    await database.delete().eq('id', gameModel.id!);
  }
}
