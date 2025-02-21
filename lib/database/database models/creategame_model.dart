class CreategameModel {
  int? id;
  String game;
  String creator;
  String? creator_email;
  String? created_at;
  String invited_users;
  bool public;

  CreategameModel({
    this.id,
    required this.game,
    required this.creator,
    required this.creator_email,
    this.created_at,
    required this.invited_users,
    required this.public,
  });

  //Info: map -> Userinfo
  factory CreategameModel.fromMap(Map<String, dynamic> map) {
    return CreategameModel(
      id: map['id'] as int?,
      game: map['game'] as String,
      creator: map['creator'] as String,
      creator_email: map['creator_email'] as String,
      created_at: map['created_at'] as String,
      invited_users: map['invited_users'] as String,
      public: map['public'] as bool,
    );
  }

  //Info: Userinfo -> map
  Map<String, dynamic> toMap() {
    return {
      'game': game,
      'creator': creator,
      'creator_email': creator_email,
      'invited_users': invited_users,
      'public': public,
    };
  }
}
