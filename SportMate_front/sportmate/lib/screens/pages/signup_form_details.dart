import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sportmate/logic/user.dart';
import 'package:sportmate/screens/widgets/dialog_builder.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';
import 'package:sportmate/logic/genre_enum.dart';


/// Seconde page d'inscription avec les informations complémentaires
class SignUpFormDetails extends StatefulWidget {
  final User user;

  const SignUpFormDetails({Key? key, required this.user}) : super(key: key);

  @override
  _SignUpFormDetailsState createState() => _SignUpFormDetailsState();
}

class _SignUpFormDetailsState extends State<SignUpFormDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    Genre dropdownValue = Genre.N;

    TextEditingController _nom = TextEditingController();
    TextEditingController _prenom = TextEditingController();
    TextEditingController _desc = TextEditingController();

    Response rep;

    return Scaffold(
        backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => {
                Navigator.of(context).pop()
              },
              icon: const Icon(Icons.close)
          ),
          title: Row(
            children : const [
              Expanded(
                child: Text(
                  "Informations supplémentaires",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() && user.birthdayDate != null) {
                  user.sexe = dropdownValue;
                  user.firstName = _prenom.text;
                  user.lastName = _nom.text;
                  user.description = _desc.text;

                  rep = await InheritedServices.of(context).services.apis.userApi.register(user);

                  showGeneralDialog(
                    context: context,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return DialogBuilder(message: jsonDecode(rep.body)['message']);
                    },
                  );
                }
              },
              icon: const Icon(Icons.check)
            )
          ],
        ),
        body : ListView(
          children : [
            Form(
              key : _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Nom
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _nom,
                      validator: (String? value){
                        if(value == null ||value.isEmpty){
                          return "Ce champ ne peut pas être vide";
                        }
                        return null;
                      },
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        helperStyle: TextStyle(
                          color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                        ),
                        labelText: "Nom",
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
                  //Prénom
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _prenom,
                      validator: (String? value){
                        if(value == null ||value.isEmpty){
                          return "Ce champ ne peut pas être vide";
                        }
                        return null;
                      },
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        helperStyle: TextStyle(
                          color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                        ),
                        labelText: "Prénom",
                        labelStyle: TextStyle(
                            color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                        ),
                      ),
                      style: TextStyle(
                        color: InheritedServices.of(context).services.couleurs.textColor
                      ),
                      cursorColor: InheritedServices.of(context).services.couleurs.textColor
                    ),
                  ),
                  //DateTime
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Date de naissance :",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: InheritedServices.of(context).services.couleurs.textColor
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child : Center(
                          child: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            color: InheritedServices.of(context).services.couleurs.textColor,
                            iconSize: 50,
                              onPressed: () async => {
                              user.birthdayDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now()
                              )
                            }
                          ),
                        ),
                      ),
                    ]
                  ),
                  //Description
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _desc,
                      validator: (String? value){
                        if(value == null ||value.isEmpty){
                          return "Ce champ ne peut pas être vide";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLength: 255,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        helperStyle: TextStyle(
                          color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                        ),
                        labelText: "Description",
                        labelStyle: TextStyle(
                            color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                        ),
                      ),
                      style: TextStyle(
                          color: InheritedServices.of(context).services.couleurs.textColor
                      ),
                      cursorColor: InheritedServices.of(context).services.couleurs.textColor
                    ),
                  ),
                  //Sexe
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child : DropdownButtonFormField(
                      value: dropdownValue,
                      onChanged: (Genre? newValue) {
                        dropdownValue = newValue!;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        color: InheritedServices.of(context).services.couleurs.textColor
                      ),
                      dropdownColor: Color(InheritedServices.of(context).services.couleurs.bgColor.value+5),
                      items: const [
                        DropdownMenuItem(
                          value: Genre.H,
                          enabled: true,
                          child: Text("Homme")
                        ),
                        DropdownMenuItem(
                          value: Genre.F,
                          enabled: true,
                          child: Text("Femme")
                        ),
                        DropdownMenuItem(
                          value: Genre.N,
                          enabled: true,
                          child: Text("Non-binaire")
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ]
        )
    );
  }
}
