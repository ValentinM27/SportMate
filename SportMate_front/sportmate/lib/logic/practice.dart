/// Classe permettant de modéliser un sport pratiqué
class Practice {
  int? idSport;
  String? label;

  Practice({this.idSport, this.label});

  /// Permet de créer un objet practice grâce à un json
  factory Practice.fromJson(Map<String, dynamic> json) {
    return Practice(idSport: int.parse(json['idSport']), label: json['Label']);
  }
}
