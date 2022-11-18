import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sportmate/logic/token.dart';
import 'link_api.dart';
import '../friend.dart';

/// Classe permettant de gérer les end points relatif au système d'amis
class FriendApi {
  /// Permet de récupérer les demande d'amis de l'utilisateur
  Future<List<Friend>> retrieveFriendRequest() async {
    String t = await Token.readToken();

    final response = await get(Uri.parse(LinkApi.link + 'friend/friendRequest'),
        headers: <String, String>{
          'Content-Type': 'application/json; Charset=utf-8',
          HttpHeaders.authorizationHeader: t
        });

    Map<String, dynamic> json = jsonDecode(response.body);

    List<Friend> friends = [];

    if(json.containsKey("demandes")){
      List<dynamic> listFriends = json["demandes"];

      for (var element in listFriends) {
        friends.add(Friend.fromJson(element));
      }
    }

    return friends;
  }

  /// Permet de récupérer la liste d'amis de l'utilisateur connecté
  Future<List<Friend>> retrieveListFriend() async {
    String t = await Token.readToken();

    final response = await get(
        Uri.parse(LinkApi.link + 'friend/retrieveFriend'),
        headers: <String, String>{
          'Content-Type': 'application/json; Charset=utf-8',
          HttpHeaders.authorizationHeader: t
        });

    Map<String, dynamic> json = jsonDecode(response.body);

    List<Friend> friends = [];

    if(json.containsKey("amis")) {
      List<dynamic> listFriends = json["amis"];

      for (var element in listFriends) {
        friends.add(Friend.fromJson(element));
      }
    }

    return friends;
  }

  /// Permet d'envoyer une demande d'ami à un utilisateur grâce à son email
  Future<Response> createFriendship(String friendEmail) async {
    String t = await Token.readToken();

    return await post(Uri.parse(LinkApi.link + 'friend/createFriendship'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode({"friendEmail": friendEmail}));
  }

  /// Permet de valider un demande d'ami grâce à son id
  Future<Response> validateFriendship(int idFriendship) async {
    String t = await Token.readToken();

    return await post(Uri.parse(LinkApi.link + 'friend/validateRequest'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode({"idFriendship": idFriendship}));
  }

  /// Permet de supprimer un amitié grâce à son id
  Future<Response> deleteFriendship(int idFriendship) async {
    String t = await Token.readToken();

    return await post(Uri.parse(LinkApi.link + 'friend/deleteFriend'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode({"idFriendship": idFriendship}));
  }
}
