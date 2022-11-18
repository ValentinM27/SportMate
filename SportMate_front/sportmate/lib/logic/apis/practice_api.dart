import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sportmate/logic/token.dart';
import 'link_api.dart';
import '../practice.dart';

/// Classe permettant de gérer les endpoint de practice
class PracticeApi {
  /// Permet d'ajouter un sport pratiqué par l'utilisateur
  /// connecté grâce à l'id du sport
  Future<Response> setPractice(int idSport) async {
    String t = await Token.readToken();

    return await post(Uri.parse(
        LinkApi.link + 'practices/setPractices'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode({'idSport': idSport}));
  }

  /// Permet de supprimer un sport pratiqués par l'utilisateur connecté
  /// grâce à l'id du sport
  Future<Response> deletePractice(int idSport) async {
    String t = await Token.readToken();

    return await post(
        Uri.parse(LinkApi.link + 'practices/deletePractices'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode({'idSport': idSport}));
  }

  /// Permet de récupérer les sports pratiqués par l'utilisateur connecté
  /// sous forme d'un liste d'objet Practice
  Future<List<Practice>> retrievePractices() async {
    String t = await Token.readToken();

    final response = await get(
        Uri.parse(LinkApi.link + 'practices/retrievePractices'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: t
        });

    Map<String, dynamic> json = jsonDecode(response.body);
    List<Practice> practices = [];


    if(json.containsKey("Pratiques")){
      List<dynamic> listPractices = json["Pratiques"];
      for (var element in listPractices) {
        practices.add(Practice(
          label: element["Label"],
          idSport: element["idSport"]
        ));
      }
    }else{
      practices.add(Practice(idSport: 0, label: "ERROR"));
    }

    return practices;
  }

  /// Permet de récupérer la liste des sport pratiqués par un utilisateur
  /// grâce à son Email
  Future<List<Practice>> retrievePracticesByEmail(String email) async {
    String t = await Token.readToken();

    final response = await post(
        Uri.parse(LinkApi.link + 'practices/retrievePracticesByEmail'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode({"Email": email}));

    Map<String, dynamic> json = jsonDecode(response.body);
    List<Practice> practices = [];

    if(json.containsKey("Practices")){
      List<dynamic> listPractices = json["Practices"];
      for (var element in listPractices) {
        practices.add(element);
      }
    }else{
      practices.add(Practice(idSport: 0, label: "ERROR"));
    }

    return practices;
  }
}
