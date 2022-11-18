/// Class permettant de modéliser une amitié
class Friend {
  int? idFriendship;
  String? lastName;
  String? firstName;
  bool? isValided;
  String? email;

  Friend(
      {required this.idFriendship,
      required this.lastName,
      required this.firstName,
      required this.email,
      required this.isValided});

  /// Permet de créer un objet de type Friend grâce à un Json
  factory Friend.fromJson(Map<String, dynamic> json) {
    int? idFriendship;
    String? lastName;
    String? firstName;
    bool? isValided;
    String? email;

    if (json.containsKey("idFriendship")) {
      idFriendship = json["idFriendship"] as int;
    }

    if (json.containsKey("LastName")) {
      lastName = json["LastName"];
    }

    if (json.containsKey("FirstName")) {
      firstName = json["FirstName"];
    }

    if (json.containsKey("IsValided")) {
      isValided = (json["IsValided"] as int == 0 ? false : true);
    }

    if (json.containsKey("Email")) {
      email = json["Email"];
    }

    return Friend(
        idFriendship: idFriendship,
        lastName: lastName,
        firstName: firstName,
        isValided: isValided,
        email: email);
  }

  /// Permet de créer un Json grâce à un objet Friend
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};

    if (idFriendship != null) {
      map["idFriendship"] = idFriendship;
    }

    if (firstName != null) {
      map["FirstName"] = firstName;
    }

    if (lastName != null) {
      map["LastName"] = lastName;
    }

    if (isValided != null) {
      map["IsValided"] = isValided;
    }

    if (email != null) {
      map["Email"] = email;
    }

    return map;
  }
}
