/// Classe permettant de créer un objet commentaire
class Comment {
  int? idComm;
  String? commentContent;
  String? lastName;
  String? firstName;
  int? idEvent;
  String? eMail;

  Comment({
    required this.idComm,
    required this.commentContent,
    required this.lastName,
    required this.firstName,
    required this.idEvent,
    required this.eMail
  });

  /// Permet de créer un objet commentaire grâce à un json
  factory Comment.fromJson(Map<String, dynamic> json) {
    int? idComm;
    String? lastName;
    String? firstName;
    String? commentContent;
    int? idEvent;
    String? eMail;

    if (json.containsKey("idComm")) {
      idComm = json["idComm"] as int;
    }

    if (json.containsKey("LastName")) {
      lastName = json["LastName"];
    }

    if (json.containsKey("FirstName")) {
      firstName = json["FirstName"];
    }

    if (json.containsKey("CommentContent")) {
      commentContent = json["CommentContent"];
    }

    if (json.containsKey("idEvent")) {
      idEvent = json["idEvent"] as int;
    }

    if (json.containsKey("Email")) {
      eMail = json["Email"];
    }

    return Comment(
      eMail: eMail,
      idComm: idComm,
      lastName: lastName,
      firstName: firstName,
      commentContent: commentContent,
      idEvent: idEvent);
  }

  /// Permet de créer un json à partir d'un objet comment
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};

    if (idComm != null) {
      map["idComment"] = idComm;
    }

    if (lastName != null) {
      map["lastName"] = lastName;
    }

    if (lastName != null) {
      map["lastName"] = lastName;
    }

    if (commentContent != null) {
      map["comment"] = commentContent;
    }

    if (idEvent != null) {
      map["idEvent"] = idEvent;
    }

    return map;
  }
}
