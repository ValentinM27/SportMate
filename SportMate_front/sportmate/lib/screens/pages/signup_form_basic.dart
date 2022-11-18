import 'package:flutter/material.dart';
import 'package:sportmate/logic/user.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

/// Première page d'inscription avec login et mot de passe
class SignUpFormBasic extends StatefulWidget {
  const SignUpFormBasic({Key? key}) : super(key: key);

  @override
  _SignUpFormBasicState createState() => _SignUpFormBasicState();
}

class _SignUpFormBasicState extends State<SignUpFormBasic> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController password = TextEditingController();
  TextEditingController validatePassword = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User u;

    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async => {
              Navigator.of(context).pop()
            },
            icon: const Icon(Icons.close)
        ),
        title: Row(
          children : const [
            Expanded(
              child: Text(
                "S'inscrire",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => {
              if(_formKey.currentState!.validate()){
                u = User(
                    firstName: null,
                    lastName: null,
                    birthdayDate: null,
                    description: null,
                    eMail: email.text,
                    sexe: null,
                    password: password.text,
                    validatePassword: validatePassword.text
                ),

                Navigator.of(context).pushNamed("/signup/details",arguments: u)
              }
            },
            icon: const Icon(Icons.check)
          )
        ],
      ),
      body: ListView(
        children : [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //mail
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: email,
                    maxLength: 125,
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return "Ce champ ne peut pas être vide";
                      }
                      //TODO check regex
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Adresse mail",
                      helperStyle: TextStyle(
                        color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                      ),
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
                //mot de passe
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    maxLength: 50,
                    controller: password,
                    obscureText: true,
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return "Ce champ ne peut pas être vide";
                      }else if(value != validatePassword.text){
                        return "Les mots de passe ne correspondent pas";
                      }
                      //TODO check regex pour password requirements

                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Mot de passe",
                      helperText: "Le mot de passe doit contenir une majuscule, une minuscule, un chiffre et doit faire minimum 8 caractères",
                      helperMaxLines: 2,
                      helperStyle: TextStyle(
                        color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                      ),
                      labelStyle: TextStyle(
                          color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                      ),
                    ),
                    style: TextStyle(
                        color: InheritedServices.of(context).services.couleurs.textColor
                    ),
                    cursorColor: InheritedServices.of(context).services.couleurs.textColor
                  )
                ),
                //validate password
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: validatePassword,
                    maxLength: 50,
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return "Ce champ ne peut pas être vide";
                      }else if(value != password.text){
                        return "Les mots de passe ne correspondent pas";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Confirmation",
                      helperStyle: TextStyle(
                        color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                      ),
                      labelStyle: TextStyle(
                          color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                      ),
                    ),
                    style: TextStyle(
                        color: InheritedServices.of(context).services.couleurs.textColor
                    ),
                    cursorColor: InheritedServices.of(context).services.couleurs.textColor
                  ),
                )
              ],
            ),
          ),
        ]
      ),
    );
  }

  @override
  void dispose() {
    password.dispose();
    validatePassword.dispose();
    email.dispose();
    super.dispose();
  }
}
