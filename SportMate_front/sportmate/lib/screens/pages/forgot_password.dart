import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sportmate/logic/apis/link_api.dart';
import 'package:sportmate/screens/widgets/dialog_builder.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

/// Page en cas d'oubli de mot de passe
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _mail = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: AppBar(
        title: const Text('SportMate'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _mail,
                validator: (String? value) {
                  if(value == null || value.isEmpty){
                    return "Le champ ne peut pas être vide";
                  }

                  //TODO regex pour check mail

                  return null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                  ),
                ),
                style: TextStyle(
                    color: InheritedServices.of(context).services.couleurs.textColor
                ),
                cursorColor: InheritedServices.of(context).services.couleurs.textColor,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if(_form.currentState!.validate()){
                Map<String, dynamic> map = {
                  "Email" : _mail.text
                };

                Response rep = await post(
                  Uri.parse(LinkApi.link+'user/resetPassword'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(map),
                );

                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogBuilder(message: jsonDecode(rep.body)["message"]+"\n"+"Si cette adresse mail est bien liée à un compte, vérifiez votre boîte mail afin de réinitialiser votre mot de passe.");
                  },
                ).then(
                    (val) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                );
              }
            },
            child: const Text("Réinitialiser le mot de passe")
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
