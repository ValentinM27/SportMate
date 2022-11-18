import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sportmate/logic/apis/link_api.dart';
import 'package:sportmate/logic/token.dart';
import 'package:sportmate/logic/user.dart';
import '../genre_enum.dart';

class UserApi{
  Future<Response> register(User user) async{
    final response = await post(
      Uri.parse(LinkApi.link+'user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    return response;
  }

  Future<Response> login(User user) async{
    return await post(
      Uri.parse(LinkApi.link+'user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
  }

  Future<User> dataUser() async{
    final response = await get(
      Uri.parse(LinkApi.link+'user/dataUser'),
      headers: {
        HttpHeaders.authorizationHeader : await Token.readToken(),
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> list = jsonDecode(response.body)["data"];
    Map<String, dynamic> json = list[0];

    Genre sexe;
    switch(json['Sexe']){
      case "H":
        sexe = Genre.H;
        break;
      case "F":
        sexe = Genre.F;
        break;
      default:
        sexe = Genre.N;
        break;
    }

    return User(
      firstName: json['FirstName'],
      lastName: json['LastName'],
      birthdayDate: null,
      description: json['Description'],
      eMail: json['Email'],
      sexe: sexe,
      password: null,
      validatePassword: null
    );
  }

  Future<String> passwordChange(User user) async{
    final response = await post(
      Uri.parse(LinkApi.link+'user/passwordChange'),
      headers: {
        HttpHeaders.authorizationHeader : await Token.readToken(),
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user)
    );
    var json = jsonDecode(response.body);

    return json['message'];
  }

  Future<String> deleteUser() async{
    final response = await delete(
      Uri.parse(LinkApi.link+'user/deleteUser'),
      headers: {
        HttpHeaders.authorizationHeader : await Token.readToken(),
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var json = jsonDecode(response.body);

    return json['message'];
  }

  Future<Response> updateUser(User user) async {
    return post(
        Uri.parse(LinkApi.link+'user/updateUser'),
        headers: {
          HttpHeaders.authorizationHeader : await Token.readToken(),
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user)
    );
  }

  Future<String> emailChange(User user) async{
    final response = await post(
        Uri.parse(LinkApi.link+'user/emailChange'),
        headers: {
          HttpHeaders.authorizationHeader : await Token.readToken(),
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user)
    );

    var json = jsonDecode(response.body);

    return json['message'];
  }

  Future<dynamic> search(String name) async{
    final response = await post(
        Uri.parse(LinkApi.link+'user/search'),
        headers: {
          HttpHeaders.authorizationHeader : await Token.readToken(),
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "name" : name
        })
    );

    Map<String, dynamic> temp = jsonDecode(response.body);

    var res;

    if(temp.containsKey("personnes")){
      res = temp["personnes"];
    }else if(temp.containsKey("message")){
      res = temp["message"];
    }

    return res;
  }

  Future<bool> isTokenExpired() async {
    final response = await get(
      Uri.parse(LinkApi.link+'user/checkToken'),
      headers: {
        HttpHeaders.authorizationHeader : await Token.readToken(),
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    bool res = false;
    
    if(json.containsKey('error')){
      res = true;
    }

    return res;
  }
}