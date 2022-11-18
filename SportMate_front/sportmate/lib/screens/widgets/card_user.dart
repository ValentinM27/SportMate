import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sportmate/logic/apis/friend_api.dart';
import 'package:sportmate/logic/mail.dart';
import 'package:sportmate/logic/user.dart';

class CardUser extends StatefulWidget {
  final User user;
  CardUser({Key? key, required this.user}) : super(key: key);

  @override
  _CardUserState createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  @override
  Widget build(BuildContext context) {
    FriendApi fa = FriendApi();
    return Card(
      color: const Color(0xFF870000),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              showGeneralDialog(
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SimpleDialog(
                    title: Text("${widget.user.firstName} ${widget.user.lastName}"),
                    titlePadding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 2.0),
                    contentPadding: const EdgeInsets.all(8.0),
                    children: [
                      Column(
                        children: [
                          Text(widget.user.genre),
                          Text("${widget.user.description}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                          Icons.close
                                      ),
                                      Text("Annuler")
                                    ],
                                  )
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  Future<String> userEmail = Mail.readMail();

                                  return FutureBuilder(
                                    future: userEmail,
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        String mail = snapshot.data as String;
                                        if(mail == widget.user.eMail){
                                          return const SizedBox.shrink();
                                        }else{
                                          return ElevatedButton(
                                            onPressed: () async {
                                              Response rep = await fa.createFriendship(widget.user.eMail!);


                                              String message = jsonDecode(rep.body)["message"];

                                              SnackBar snackBar = SnackBar(
                                                  content: Text(message)
                                              );

                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                    Icons.add_reaction_outlined
                                                ),
                                                Text("Ajoutez en ami")
                                              ],
                                            )
                                          );
                                        }
                                      }else if(snapshot.hasError){
                                        return const SizedBox.shrink();
                                      }else{
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    },
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  );
                },
              );
            },
            title: Text("${widget.user.firstName} ${widget.user.lastName}", style: const TextStyle(color: Color(0xFFE0E2DB), fontWeight: FontWeight.bold)),
            subtitle: Text("${(DateTime.now().difference(widget.user.birthdayDate!).inDays/365.25).floor()} ans", style: const TextStyle(color: Color(0xFFE0E2DB))),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text("${widget.user.description}", style: const TextStyle(color: Color(0xFFE0E2DB))),
          )
        ],
      ),
    );
  }
}