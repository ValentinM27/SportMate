import 'genre_enum.dart';

/// Classe permettant de créer un objet utilisateur
class User{
  String? firstName;
  String? lastName;
  DateTime? birthdayDate;
  String? description;
  String? eMail;
  Genre? sexe;
  String? password;
  String? validatePassword;

  User(
    {
      required this.firstName,
      required this.lastName,
      required this.birthdayDate,
      required this.description,
      required this.eMail,
      required this.sexe,
      required this.password,
      required this.validatePassword
    }
  );

  /// Permet de créer un objet utilisateur grâce à un json
  factory User.fromJson(Map<String, dynamic> json){
    String? fn;
    String? ln;
    DateTime? bd;
    String? d;
    String? e;
    String? s;

    if(json.containsKey("FirstName")){
      fn = json["FirstName"];
    }

    if(json.containsKey("LastName")){
      ln = json["LastName"];
    }

    if(json.containsKey("BirthdayDate")){
      try{
        bd = DateTime.parse(json["BirthdayDate"]);
      }on Exception{
        bd = null;
      }
    }

    if(json.containsKey("Description")){
      d = json["Description"];
    }

    if(json.containsKey("Email")){
      e = json["Email"];
    }

    if(json.containsKey("Sexe")){
      s = json["Sexe"];
    }

    final Genre sexe;
    switch(s){
      case "N":
        sexe = Genre.N;
        break;
      case "F":
        sexe = Genre.F;
        break;
      case "H":
        sexe = Genre.H;
        break;
      default:
        sexe = Genre.N;
    }

    return User(
      firstName: fn,
      lastName: ln,
      birthdayDate: bd,
      description: d,
      eMail: e,
      sexe: sexe,
      password: null,
      validatePassword: null
    );
  }

  /// Permet de créer un json à partir d'un objet comment
  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = <String, dynamic>{};

    if(validatePassword != null){
      map['validatePASSWORD'] = validatePassword;
    }

    if(password != null){
      map['PASSWORD'] = password;
    }

    if(sexe != null){
      switch(sexe){
        case Genre.N:
          map['Sexe'] = 'N';
          break;
        case Genre.F:
          map['Sexe'] = 'F';
          break;
        case Genre.H:
          map['Sexe'] = 'H';
          break;
        default:
          map['Sexe'] = 'N';
      }
    }

    if(eMail != null){
      map['Email'] = eMail;
    }

    if(lastName != null){
      map['LastName'] = lastName;
    }

    if(firstName != null){
      map['FirstName'] = firstName;
    }

    if(birthdayDate != null){
      map['BirthdayDate'] = birthdayDate.toString();
    }

    if(description != null){
      map['Description'] = description;
    }

    return map;
  }

  String get genre {
    String res;

    switch(sexe){
      case Genre.H:
        res = "Homme";
        break;
      case Genre.F:
        res = "Femme";
        break;
      default:
        res = "Non-Binaire";
        break;
    }

    return res;
  }

  set genre(String value) {
    Genre res;

    switch(value){
      case 'H':
        res = Genre.H;
        break;
      case 'F':
        res = Genre.F;
        break;
      default:
        res = Genre.N;
        break;
    }

    sexe = res;
  }
}