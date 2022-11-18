import 'type_event_enum.dart';

/// Classe permettant de créer un objet event
class Event {
  String? firstName;
  String? lastName;
  String? mail;
  int? idEvent;
  String? desc;
  TypeEvent? typeEvent;
  int? persMin;
  int? persMax;
  DateTime? dateEvent;
  DateTime? dateCreation;
  String? label;
  int? idSport;

  Event(
      {this.firstName,
      this.lastName,
      this.mail,
      this.idEvent,
      this.desc,
      this.typeEvent,
      this.persMin,
      this.persMax,
      this.dateEvent,
      this.dateCreation,
      this.label,
      this.idSport});

  factory Event.fromJson(Map<String, dynamic> json) {
    TypeEvent te = TypeEvent.Cours;

    switch (json['TypeEvent']) {
      case "Entrainement":
        te = TypeEvent.Entrainement;
        break;
      case "Cours":
        te = TypeEvent.Cours;
        break;
      case "Competition":
        te = TypeEvent.Competition;
        break;
    }

    return Event(
        firstName: json['FirstName'],
        lastName: json['LastName'],
        mail: json['Email'],
        idEvent: json['idEvent'],
        desc: json['DESCRIPTION_EVENT'],
        typeEvent: te,
        persMin: json['PersMin'],
        persMax: json['PersMax'],
        dateEvent: DateTime.parse(json['DateEvent']).toLocal(),
        dateCreation: DateTime.parse(json['DateCreation']).toLocal(),
        label: json['Label']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['DESCRIPTION_EVENT'] = desc;

    switch (typeEvent) {
      case TypeEvent.Cours:
        map["TypeEvent"] = "Cours";
        break;
      case TypeEvent.Entrainement:
        map["TypeEvent"] = "Entrainement";
        break;
      case TypeEvent.Competition:
        map["TypeEvent"] = "Competition";
        break;
      default:
        map["TypeEvent"] = "Entrainement";
        break;
    }

    map["Email"] = mail;
    map['DateEvent'] = dateEvent.toString();
    map['idSport'] = idSport;

    if (persMin != null) map['PersMin'] = persMin;
    if (persMax != null) map['PersMax'] = persMax;

    return map;
  }
}
