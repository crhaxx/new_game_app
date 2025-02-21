class Userinfo {
  int? id;
  String username;

  Userinfo({
    required this.id,
    required this.username,
  });

  //Info: map -> Userinfo
  factory Userinfo.fromMap(Map<String, dynamic> map) {
    return Userinfo(
      id: map['id'] as int?,
      username: map['username'] as String,
    );
  }

  //Info: Userinfo -> map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
    };
  }
}
