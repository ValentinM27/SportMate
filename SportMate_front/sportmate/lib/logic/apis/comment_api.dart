import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sportmate/logic/token.dart';
import 'link_api.dart';
import '../comment.dart';

/// Classe permettant de gérer les endpoint de comment
class CommentApi {
  /// Permet de récupérer la liste des commentaire d'un event grâce à l'id de
  /// l'event
  Future<List<Comment>> retrieveComment(int idEvent) async {
    String t = await Token.readToken();

    final response = await post(
        Uri.parse(LinkApi.link + 'comment/retrieveComment'),
        headers: <String, String>{
          'Content-Type': 'application/json; Charset=utf-8',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode({"idEvent": idEvent})
      );

    List<Comment> comments = [];

    Map<String, dynamic> json = jsonDecode(response.body);

    if(json.containsKey("Comments")){
      List<dynamic> listComment = json["Comments"];

      for (var element in listComment) {
        comments.add(Comment.fromJson(element));
      }
    }else{
      comments.add(
        Comment(
          eMail: "sportmate.mail@gmail.com",
          lastName: "de Sport'mate",
          firstName: "Les administrateurs",
          commentContent: "Oups ! On dirait que cet évènement n'as pas de commentaires, pourquoi ne seriez vous pas le premier ?",
          idEvent: null,
          idComm: null,
        )
      );
    }

    return comments;
  }

  /// Permet de créer un commentaire via un objet Comment
  Future<Response> createComment(Comment comment) async {
    String t = await Token.readToken();

    return await post(Uri.parse(LinkApi.link + 'comment/createComment'),
        headers: <String, String>{
          'Content-Type': 'application/json; Charset=utf-8',
          HttpHeaders.authorizationHeader: t
        },
        body: jsonEncode(comment));
  }

  /// Permet de supprimer un commentaire grâce à son id
  Future<Response> deleteComment(int idComment) async {
    String t = await Token.readToken();

    return await post(
      Uri.parse(LinkApi.link + 'comment/deleteComment'),
      headers: <String, String>{
        'Content-Type': 'application/json; Charset=utf-8',
        HttpHeaders.authorizationHeader: t
      },
      body: jsonEncode({"idComment": idComment})
    );
  }
}
