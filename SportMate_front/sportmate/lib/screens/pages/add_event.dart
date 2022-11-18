import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:sportmate/logic/event.dart';
import 'package:sportmate/logic/type_event_enum.dart';
import 'package:sportmate/screens/widgets/custom_appbar.dart';
import 'package:sportmate/screens/widgets/custom_bottombar.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class AddEventPage extends StatefulWidget {
  final Event e = Event();
  AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _sport = TextEditingController();
  final TextEditingController _persMin = TextEditingController();
  final TextEditingController _persMax = TextEditingController();
  final TextEditingController _date = TextEditingController();

  @override
  void dispose() {
    _desc.dispose();
    _sport.dispose();
    _persMax.dispose();
    _persMin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TypeEvent dropdownValue = TypeEvent.Entrainement;

    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: CustomAppBar(),
      body: Form(
          key: _form,
          child: ListView(
            children: [
              ///Description de l'event
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: _desc,
                    maxLength: 255,
                    maxLines: null,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Le champ ne doit pas être vide";
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Description",
                      helperStyle: TextStyle(
                        color: InheritedServices.of(context)
                            .services
                            .couleurs
                            .textColor
                            .withOpacity(0.4),
                      ),
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
                        .textColor),
              ),

              ///TypeEvent
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DropdownButtonFormField(
                    value: dropdownValue,
                    onChanged: (value) {
                      dropdownValue = value as TypeEvent;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                        color: InheritedServices.of(context)
                            .services
                            .couleurs
                            .textColor),
                    dropdownColor: Color(InheritedServices.of(context)
                            .services
                            .couleurs
                            .bgColor
                            .value +
                        5),
                    items: const [
                      DropdownMenuItem(
                          value: TypeEvent.Entrainement,
                          enabled: true,
                          child: Text("Entrainement")),
                      DropdownMenuItem(
                          value: TypeEvent.Cours,
                          enabled: true,
                          child: Text("Cours")),
                      DropdownMenuItem(
                          value: TypeEvent.Competition,
                          enabled: true,
                          child: Text("Competition"))
                    ]),
              ),

              ///Participants
              Row(
                children: [
                  ///Pers min
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _persMin,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("([0-9])"),
                              allow: true)
                        ],
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            helperStyle: TextStyle(
                              color: InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .textColor
                                  .withOpacity(0.4),
                            ),
                            labelText: "Participant minimum",
                            labelStyle: TextStyle(
                              color: InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .textColor
                                  .withOpacity(0.4),
                            ),
                            helperText: "Facultatif"),
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
                  ),

                  ///Pers max
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _persMax,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("([0-9])"),
                              allow: true)
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            helperStyle: TextStyle(
                              color: InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .textColor
                                  .withOpacity(0.4),
                            ),
                            labelText: "Participants maximum",
                            labelStyle: TextStyle(
                              color: InheritedServices.of(context)
                                  .services
                                  .couleurs
                                  .textColor
                                  .withOpacity(0.4),
                            ),
                            helperText: "Facultatif"),
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
                  ),
                ],
              ),

              ///Date
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 76,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          enabled: false,
                          controller: _date,
                          decoration: InputDecoration(
                            labelText: "Date de l'évènement",
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
                              .textColor),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.calendar_today),
                      color: InheritedServices.of(context)
                          .services
                          .couleurs
                          .textColor,
                      iconSize: 50,
                      onPressed: () async => {
                            widget.e.dateEvent = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 5)),
                            _date.text =
                                "${widget.e.dateEvent!.day}/${widget.e.dateEvent!.month}/${widget.e.dateEvent!.year}"
                          }),
                ]),
              ),

              ///Label sport
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          cancelButton: ElevatedButton(
                              child: const Text("OK !"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(400)))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          actions: [cupertinoPopUpBuilder()],
                          title: const Text("Choix du sport"),
                        ),
                      );
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _sport,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Sport :",
                        helperStyle: TextStyle(
                          color: InheritedServices.of(context)
                              .services
                              .couleurs
                              .textColor
                              .withOpacity(0.4),
                        ),
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
                  )),

              ///Bouton création évènement
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  child: const Text("Créer l'évènement"),
                  onPressed: () async {
                    widget.e.typeEvent = dropdownValue;
                    if (_persMax.text.isNotEmpty)
                      widget.e.persMax = int.parse(_persMax.text);
                    if (_persMin.text.isNotEmpty)
                      widget.e.persMin = int.parse(_persMin.text);
                    widget.e.desc = _desc.text;

                    Response rep = await InheritedServices.of(context)
                        .services
                        .apis
                        .eventApi
                        .createEvent(widget.e);

                    if (rep.statusCode != 200) {
                      showDialog(
                              builder: (context) {
                                return SimpleDialog(
                                  title: const Text("Erreur !"),
                                  children: [
                                    Text(jsonDecode(rep.body)["message"] +
                                        " Code d'erreur : ${rep.statusCode}")
                                  ],
                                );
                              },
                              context: context)
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          )),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }

  Widget cupertinoPopUpBuilder() {
    return SizedBox(
      height: 200,
      child: CupertinoPicker(
          itemExtent: 64,
          onSelectedItemChanged: (value) {
            setState(() {
              widget.e.idSport = value + 1;
              if (InheritedServices.of(context)
                      .services
                      .sportEnum
                      .sports[value + 1] !=
                  null) {
                _sport.text = InheritedServices.of(context)
                    .services
                    .sportEnum
                    .sports[value + 1] as String;
              }
            });
          },
          children: InheritedServices.of(context)
              .services
              .sportEnum
              .getListWidgets()),
    );
  }
}
