import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sportmate/logic/token.dart';
import 'package:sportmate/logic/type_event_enum.dart';
import '../event.dart';
import 'link_api.dart';

class EventApi {
  Future<List<Event>> retrieveEvent() async {
    String t = await Token.readToken();

    final response = await get(Uri.parse(LinkApi.link + 'event/retrieveEvent'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: t
        });

    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> listEvents = json["event"];

    List<Event> events = [];

    for (var element in listEvents) {
      events.add(Event.fromJson(element));
    }

    return events;
  }

  /// Permet la récupération des events créés par l'utilisateur connecté
  Future<List<Event>> retrieveEventByCurrentUser() async {
    String t = await Token.readToken();

    final response = await get(
        Uri.parse(LinkApi.link + 'event/retrieveEventByCurrentUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: t
        });

    Map<String, dynamic> json = jsonDecode(response.body);
    List<Event> events = [];

    if(json.containsKey("Evenements")){
      List<dynamic> listEvents = json["Evenements"];
      /// On replit la liste avec les différents events
      /// Si il n'existe aucun event => on retourne une liste vide
      for (var element in listEvents) {
        events.add(Event.fromJson(element));
      }
    }else{
      events.add(
        Event(
            lastName: "de Sport'Mate",
            firstName: "Les développeurs",
            idEvent: null,
            dateCreation: DateTime.now(),
            dateEvent: DateTime.now(),
            desc: "On dirait que vos amis n'ont pas encore créés d'évènements. Soyez le premier parmi tes amis à en créer un !",
            idSport: 1,
            label: "BASKET",
            mail: null,
            persMax: null,
            persMin: null,
            typeEvent: TypeEvent.Cours
        )
      );
    }

    return events;
  }

  /// Permet de récupérer les events organisés par les amis de l'utilisateurs
  Future<List<Event>> retrieveEventByFriendsList() async {
    String t = await Token.readToken();

    final response = await get(
      Uri.parse(LinkApi.link + 'event/retrieveEventByFriendsList'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: t
      }
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> listEvents = [];
    List<Event> events = [];


    if(json.containsKey('Events')){
      listEvents = json["Events"];

      for (var element in listEvents) {
        events.add(Event.fromJson(element));
      }
    }else if(json.containsKey('message')){
      events.add(
        Event(
          lastName: "de Sport'Mate",
          firstName: "Les développeurs",
          idEvent: null,
          dateCreation: DateTime.now(),
          dateEvent: DateTime.now(),
          desc: "On dirait que vos amis n'ont pas encore créés d'évènements. Sois le premier parmi tes amis à en créer un !",
          idSport: 1,
          label: "BASKET",
          mail: null,
          persMax: null,
          persMin: null,
          typeEvent: TypeEvent.Cours
        )
      );
    }


    return events;
  }

  /// Permet de créer un event via un objet de type Event
  Future<Response> createEvent(Event event) async {
    String t = await Token.readToken();

    final response = await post(
      Uri.parse(LinkApi.link + 'event/createEvent'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: t
      },
      body: jsonEncode(event),
    );

    return response;
  }

  /// Permet de récupérer la liste des events en fonction d'un sport grâce
  /// à l'id du Sport
  Future<List<Event>> retrieveEventBySport(int idSport) async {
    String t = await Token.readToken();

    final response = await post(
        Uri.parse(LinkApi.link + 'event/retrieveEventBySport'),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode({"idSport": idSport}));

    Map<String, dynamic> json = jsonDecode(response.body);
    List<Event> events = [];


    if(json.containsKey("Event")){
      List<dynamic> listEvents = json["Event"];
      for (var element in listEvents) {
        events.add(Event.fromJson(element));
      }
    }else{
      events.add(
          Event(
              lastName: "de Sport'Mate",
              firstName: "Les développeurs",
              idEvent: null,
              dateCreation: DateTime.now(),
              dateEvent: DateTime.now(),
              desc: "On dirait qu'il n'y a pas encore d'évènements sur ce sport. Sois le premier à en créer un !",
              idSport: 1,
              label: "Sport'Mate",
              mail: null,
              persMax: null,
              persMin: null,
              typeEvent: TypeEvent.Cours
          )
      );
    }

    return events;
  }

  /// Permet de récupérer les events organisés par utilisateur grâce à son mail
  Future<List<Event>> retrieveEventByUser(String email) async {
    String t = await Token.readToken();

    final response = await post(
      Uri.parse(LinkApi.link + 'event/retrieveEventByUser'),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: t
      },
      body: jsonEncode({"Email": email})
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> listEvents = json["Events"];

    List<Event> events = [];

    for (var element in listEvents) {
      events.add(Event.fromJson(element));
    }

    return events;
  }

  /// Permet de supprimer un Event grâce à son id
  Future<Response> deleteEvent(int idEvent) async {
    String t = await Token.readToken();

    return await post(
      Uri.parse(LinkApi.link + 'event/deleteEvent'),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: t
      },
      body: jsonEncode({"idEvent": idEvent})
    );
  }
}
