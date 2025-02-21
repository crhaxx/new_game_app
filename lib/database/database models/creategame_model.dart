class CreategameModel {
  int? id;
  String game;
  String creator;
  String creator_email;
  String created_at;

  CreategameModel({
    required this.id,
    required this.game,
    required this.creator,
    required this.creator_email,
    required this.created_at,
  });

  //Info: map -> Userinfo
  factory CreategameModel.fromMap(Map<String, dynamic> map) {
    return CreategameModel(
      id: map['id'] as int?,
      game: map['game'] as String,
      creator: map['creator'] as String,
      creator_email: map['creator_email'] as String,
      created_at: map['created_at'] as String,
    );
  }

  //Info: Userinfo -> map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'game': game,
      'creator': creator,
      'creator_email': creator_email,
      'created_at': created_at,
    };
  }
}
