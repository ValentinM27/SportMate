import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sportmate/logic/event.dart';
import 'package:sportmate/logic/genre_enum.dart';
import 'package:sportmate/logic/mail.dart';
import 'package:sportmate/logic/practice.dart';
import 'package:sportmate/logic/remember.dart';
import 'package:sportmate/logic/token.dart';
import 'package:sportmate/logic/user.dart';
import 'package:sportmate/screens/widgets/custom_appbar.dart';
import 'package:sportmate/screens/widgets/custom_bottombar.dart';
import 'package:sportmate/screens/widgets/event_widget.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

/// Page de gestion de profil
class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _description = TextEditingController();
  bool _profil = true;

  @override
  Widget build(BuildContext context) {
    Future<User> u =
        InheritedServices.of(context).services.apis.userApi.dataUser();

    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: u,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data as User;
            return userProfile(user);
          } else if (snapshot.hasError) {
            return Text(
                "Erreur lors de la récupération des données : ${snapshot.error.toString()}",
                style: TextStyle(
                    color: InheritedServices.of(context)
                        .services
                        .couleurs
                        .textColor));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }

  Widget userProfile(User user) {
    Genre _dropdownValue = user.sexe!;

    _firstName.text = user.firstName as String;
    _lastName.text = user.lastName as String;
    _mail.text = user.eMail as String;
    _description.text = user.description as String;

    var _style = TextStyle(
        color: InheritedServices.of(context).services.couleurs.textColor);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(5),
              child: TextButton(
                  onPressed: () {
                    if (!_profil) {
                      setState(() {
                        _profil = true;
                      });
                    }
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          InheritedServices.of(context)
                              .services
                              .couleurs
                              .textColor),
                      backgroundColor: !_profil
                          ? MaterialStateProperty.all<Color>(
                              InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .primarySwatch)
                          : MaterialStateProperty.all<Color>(
                              InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .primarySwatch[900]!)),
                  child: const Text("Votre profil")),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(5),
              child: TextButton(
                  onPressed: () {
                    if (_profil) {
                      setState(() {
                        _profil = false;
                      });
                    }
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          InheritedServices.of(context)
                              .services
                              .couleurs
                              .textColor),
                      backgroundColor: _profil
                          ? MaterialStateProperty.all<Color>(
                              InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .primarySwatch)
                          : MaterialStateProperty.all<Color>(
                              InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .primarySwatch[900]!)),
                  child: const Text("Vos évènements")),
            ),
          ],
        ),
      ),
      Builder(builder: (context) {
        //si on est sur le profil
        if (_profil) {
          return Expanded(
            child: ListView(children: [
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _firstName,
                        decoration: _deco("Prénom"),
                        style: _style,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _lastName,
                        decoration: _deco("Nom"),
                        style: _style,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        enabled: false,
                        controller: _mail,
                        decoration: _deco("E-mail"),
                        style: _style,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _description,
                        decoration: _deco("Description"),
                        style: _style,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: DropdownButtonFormField(
                          value: _dropdownValue,
                          onChanged: (Genre? newValue) {
                            _dropdownValue = newValue!;
                          },
                          decoration: _deco("Genre"),
                          style: _style,
                          dropdownColor: Color(InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .bgColor
                                  .value +
                              5),
                          items: const [
                            DropdownMenuItem(
                                value: Genre.H,
                                enabled: true,
                                child: Text("Homme")),
                            DropdownMenuItem(
                                value: Genre.F,
                                enabled: true,
                                child: Text("Femme")),
                            DropdownMenuItem(
                                value: Genre.N,
                                enabled: true,
                                child: Text("Non-binaire"))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FutureBuilder(
                        future: InheritedServices.of(context)
                            .services
                            .apis
                            .practiceApi
                            .retrievePractices(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Practice> listPractices =
                                snapshot.data as List<Practice>;
                            String tmp = "";

                            if (listPractices.isNotEmpty &&
                                listPractices[0].label != "ERROR") {
                              tmp =
                                  "Vous pratiquez : ${listPractices[0].label}, ";
                              listPractices.removeAt(0);

                              if (listPractices.isNotEmpty) {
                                for (var element in listPractices) {
                                  tmp += "${element.label}";
                                }
                              }

                              tmp += ".";
                            } else {
                              tmp = "Vous ne pratiquez aucun sport";
                            }

                            return Text(
                              tmp,
                              style: TextStyle(
                                  color: InheritedServices.of(context)
                                      .services
                                      .couleurs
                                      .textColor),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    "Une erreur est survenue : ${snapshot.error}"));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: ElevatedButton(
                            onPressed: () async {
                              user.sexe = _dropdownValue;
                              user.description = _description.text;
                              user.firstName = _firstName.text;
                              user.lastName = _lastName.text;

                              Response rep = await InheritedServices.of(context)
                                  .services
                                  .apis
                                  .userApi
                                  .updateUser(user);

                              if (rep.statusCode == 200) {
                                Navigator.of(context)
                                    .popUntil(ModalRoute.withName("/accueil"));
                                Navigator.of(context).pushNamed("/accueil");
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    //TODO stylisez la pop-up
                                    return SimpleDialogOption(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          const Text(
                                              "Erreur ! Veuillez réessayer\n"),
                                          Text(jsonDecode(rep.body))
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text('Mettre à jour le profil'),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(400)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: ElevatedButton(
                            onPressed: () {
                              Token.erase();
                              Remember.erase();
                              Mail.erase();
                              Navigator.of(context).popUntil((route) {
                                return route.settings.name == '/';
                              });
                              Navigator.of(context).pushNamed("/");
                            },
                            child: const Text('Déconnexion'),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(400)))),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "/accueil/profil/pratique");
                        },
                        child: const Text('Changer les sports pratiqués'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(400)))),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
          //sinon on charge ses évènements
        } else {
          return FutureBuilder(
            future: InheritedServices.of(context)
                .services
                .apis
                .eventApi
                .retrieveEventByCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Event> events = snapshot.data as List<Event>;

                return Expanded(
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return EventWidget(event: events[index]);
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Une erreur est survenue : ${snapshot.error}");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        }
      }),
    ]);
  }

  InputDecoration _deco(String s) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      labelText: s,
      labelStyle: TextStyle(
        color: InheritedServices.of(context)
            .services
            .couleurs
            .textColor
            .withOpacity(0.4),
      ),
    );
  }

  @override
  void dispose() {
    _mail.dispose();
    _description.dispose();
    _lastName.dispose();
    _firstName.dispose();

    super.dispose();
  }
}
