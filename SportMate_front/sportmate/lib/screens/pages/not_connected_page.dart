import 'package:flutter/material.dart';
import 'package:sportmate/logic/remember.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';
import 'package:sportmate/screens/widgets/login_sign_up_buttons.dart';

import 'accueil.dart';

/// Page de démarrage de l'application, avant connexion à un compte
class NotConnectedPage extends StatelessWidget {
  const NotConnectedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _futureRemember = Remember.readBool();
    bool _remember = false;

    return FutureBuilder(
      future: _futureRemember,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          _remember = snapshot.data as bool;
          if(_remember){
            Future<bool> _futureExpired = InheritedServices.of(context).services.apis.userApi.isTokenExpired();

            return FutureBuilder(
              future: _futureExpired,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  bool _expired = snapshot.data as bool;

                  if(_expired){
                    return Scaffold(
                      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
                      appBar: AppBar(
                        title: const Text('SportMate'),
                        centerTitle: true,
                      ),
                      body: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Text(
                              "Bienvenue !",
                              style: Theme.of(context).textTheme.headline3!.apply(
                                  color: InheritedServices.of(context).services.couleurs.textColor,
                                  fontStyle: FontStyle.italic
                              )
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Text(
                              "Afin d'utiliser l'application, vous devez vous connecter ou créer un compte",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: InheritedServices.of(context).services.couleurs.textColor,
                                fontStyle: FontStyle.italic
                              )
                            ),
                          ),
                          const Buttons()
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    );
                  }else{
                    ModalRoute.of(context)!.settings.copyWith(name : "/accueil");
                    return const Accueil();
                  }
                }else{
                  return Scaffold(
                    backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
                    appBar: AppBar(
                      title: const Text('SportMate'),
                      centerTitle: true,
                    ),
                    body: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          child: Text(
                              "Bienvenue !",
                              style: Theme.of(context).textTheme.headline3!.apply(
                                  color: InheritedServices.of(context).services.couleurs.textColor,
                                  fontStyle: FontStyle.italic
                              )
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          child: Text(
                              "Afin d'utiliser l'application, vous devez vous connecter ou créer un compte",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: InheritedServices.of(context).services.couleurs.textColor,
                                  fontStyle: FontStyle.italic
                              )
                          ),
                        ),
                        const Buttons()
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  );
                }
              },
            );
          }else{
            return Scaffold(
              backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
              appBar: AppBar(
                title: const Text('SportMate'),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                        "Bienvenue !",
                        style: Theme.of(context).textTheme.headline3!.apply(
                            color: InheritedServices.of(context).services.couleurs.textColor,
                            fontStyle: FontStyle.italic
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                        "Afin d'utiliser l'application, vous devez vous connecter ou créer un compte",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: InheritedServices.of(context).services.couleurs.textColor,
                            fontStyle: FontStyle.italic
                        )
                    ),
                  ),
                  const Buttons()
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            );
          }
        }else if(snapshot.hasError){
          return Scaffold(
            backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
            appBar: AppBar(
              title: const Text('SportMate'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                      "Bienvenue !",
                      style: Theme.of(context).textTheme.headline3!.apply(
                          color: InheritedServices.of(context).services.couleurs.textColor,
                          fontStyle: FontStyle.italic
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                      "Afin d'utiliser l'application, vous devez vous connecter ou créer un compte",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: InheritedServices.of(context).services.couleurs.textColor,
                          fontStyle: FontStyle.italic
                      )
                  ),
                ),
                const Buttons()
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          );
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
