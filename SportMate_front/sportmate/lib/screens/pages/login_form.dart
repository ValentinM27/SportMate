import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sportmate/logic/mail.dart';
import 'package:sportmate/logic/remember.dart';
import 'package:sportmate/logic/token.dart';
import 'package:sportmate/logic/user.dart';
import 'package:sportmate/screens/widgets/dialog_builder.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

/// Page qui gère la connexion à l'application
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _mdp = TextEditingController();
  bool _rememberValue = false;
  late User u;
  late Response response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.of(context).pop()},
            icon: const Icon(Icons.close)),
        title: Row(
          children: const [
            Expanded(
              child: Text(
                "Se connecter",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async => {
                    u = User(
                        firstName: null,
                        lastName: null,
                        birthdayDate: null,
                        description: null,
                        eMail: _mail.text,
                        sexe: null,
                        password: _mdp.text,
                        validatePassword: null),
                    if (_formKey.currentState!.validate())
                      {
                        Remember.writeBool(_rememberValue),
                        Mail.writeMail(u.eMail!),
                        response = await InheritedServices.of(context)
                            .services
                            .apis
                            .userApi
                            .login(u),
                        if (response.statusCode == 200)
                          {
                            Token.writeToken(
                                jsonDecode(response.body)['token']),
                            Navigator.popUntil(
                                context, (route) => route.settings.name == "/"),
                            Navigator.of(context).pushNamed("/accueil"),
                          }
                        else
                          {
                            showGeneralDialog(
                              context: context,
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return DialogBuilder(
                                    message:
                                        jsonDecode(response.body)['message']);
                              },
                            )
                          }
                      }
                  },
              icon: const Icon(Icons.check))
        ],
      ),
      body: ListView(
        children: [
          Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //mail
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _mail,
                      validator: (value) {
                        if (_mail.text.isEmpty) {
                          return "Le champ ne doit pas être vide";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Login (E-Mail)",
                        labelStyle: TextStyle(
                          color: InheritedServices.of(context)
                              .services
                              .couleurs
                              .textColor
                              .withOpacity(0.4),
                        ),
                      ),
                      style: TextStyle(
                        color: InheritedServices.of(context)
                            .services
                            .couleurs
                            .textColor,
                      ),
                      cursorColor: InheritedServices.of(context)
                          .services
                          .couleurs
                          .textColor,
                    ),
                  ),
                  //mdp
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _mdp,
                      obscureText: true,
                      validator: (value) {
                        if (_mail.text.isEmpty) {
                          return "Le champ ne doit pas être vide";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(
                          color: InheritedServices.of(context)
                              .services
                              .couleurs
                              .textColor
                              .withOpacity(0.4),
                        ),
                      ),
                      style: TextStyle(
                          color: InheritedServices.of(context)
                              .services
                              .couleurs
                              .textColor),
                      cursorColor: InheritedServices.of(context)
                          .services
                          .couleurs
                          .textColor,
                    ),
                  ),
                  //remember me
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: _rememberValue,
                        onChanged: (value) {
                          setState(() {
                            _rememberValue = value!;
                          });
                        },
                      ),
                      Text(
                        "Se souvenir de moi",
                        style: TextStyle(
                            color: InheritedServices.of(context)
                                .services
                                .couleurs
                                .textColor),
                      )
                    ],
                  ),
                  //MDP oublié
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      child: const Text("J'ai oublié mon mot de passe."),
                      onPressed: () {
                        Navigator.pushNamed(context, "/login/reset");
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mail.dispose();
    _mdp.dispose();
    super.dispose();
  }
}
