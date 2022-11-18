import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sportmate/logic/token.dart';
import 'link_api.dart';
import '../user.dart';
import '../event.dart';

/// Classe permettant de gérer les endpoint de join
class JoinApi {
  /// Permet de récupérer la liste des participants d'un event grâce
  /// à l'id de l'event
  Future<List<User>> retrieveParticipant(int idEvent) async {
    String t = await Token.readToken();

    final response = await post(
        Uri.parse(LinkApi.link + 'join/retrieveParticipant'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: t
        });

    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> listParticipants = json["Participants"];

    List<User> participants = [];

    for (var element in listParticipants) {
      participants.add(User.fromJson(element));
    }

    return participants;
  }

  /// Permet à l'utilisateur connecté de rejoindre un event grâce à
  /// l'id de l'event
  Future<Response> joinEvent(int idEvent) async {
    String t = await Token.readToken();

    return await post(Uri.parse(LinkApi.link + 'join/joinEvent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: t
      },
      body: jsonEncode({"idEvent": idEvent})
    );
  }

  /// Permet à l'utilisateur connecté de quitter un event qu'il a au préalable
  /// rejoint grâce à l'id de l'Event
  Future<Response> leaveEvent(int idEvent) async {
    String t = await Token.readToken();

    return await post(
      Uri.parse(LinkApi.link + 'join/leftEvent'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: t
      },
      body: jsonEncode({"idEvent": idEvent})
    );
  }

  /// Permet de récupérer la liste des events rejoint par l'utilisateur connecté
  Future<List<Event>> retrieveJoinedEvent() async {
    String t = await Token.readToken();

    final response = await get(
        Uri.parse(LinkApi.link + 'join/retrieveJoinedEvents'),
        headers: <String, String>{
          'Content-Type': 'application/json, charset=UTF-8',
          HttpHeaders.authorizationHeader: t
        });

    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> listEvents = json["Events"];

    List<Event> events = [];

    for (var element in listEvents) {
      events.add(Event.fromJson(element));
    }

    return events;
  }

  Future<bool> participate(int idEvent) async {
    String t = await Token.readToken();

    final response = await post(
      Uri.parse(LinkApi.link + 'join/participate'),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: t
      },
      body: jsonEncode({"idEvent":idEvent})
    );

    bool b;

    jsonDecode(response.body.toLowerCase())["participe"] == "true" ? b = true : b = false;

    return b;
  }
}
