import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:sportmate/logic/token.dart';
import 'apis/link_api.dart';
import 'package:flutter/material.dart';

/// Enumeration des sports possibles
class SportEnum{
  Map<int, String> sports = {};

  void getSports() async {
    Map<int, String> res = <int, String>{};
    String token = await Token.readToken();

    if(token != "ERROR"){
      final response = await get(
        Uri.parse(LinkApi.link+'sport/retrieveSports'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader : token
        },
      );

      Map<String, dynamic> json = jsonDecode(response.body);

      if(json.containsKey("Sports")){
        List<dynamic> listSports = json["Sports"];

        for (var element in listSports) {
          res[element["idSport"]] = element["Label"];
        }
      }
    }

    if(res.isEmpty) {res[1] = "ERROR";}

    sports = res;
  }

  List<Widget> getListWidgets(){
    List<Widget> list = [];

    if(sports[1] == "ERROR" || sports.isEmpty){
      getSports();
    }

    if(sports[1] == "ERROR"){
      list.add(const Center(child: Text("Une erreur est survenue, veuillez réessayer")));
    }else{
      for(int i = 0; i < sports.values.length; i++){
        list.add(Center(child: Text(sports[i+1].toString())));
      }
    }

    return list;
  }

  int getIdSportFromQuery(String query) {
    int idSport = 0;

    if (sports[1] == "ERROR" || sports.isEmpty) {
      getSports();
    }

    if(query.isNotEmpty && sports[1] != "ERROR"){
      if(sports.containsValue(query.toUpperCase())){
        sports.forEach((key, value) {
          if(value == query.toUpperCase()) {
            idSport = key;
          }
        });
      }
    }

    return idSport;
  }
}