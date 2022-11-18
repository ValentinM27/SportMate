import 'package:flutter/material.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: InheritedServices.of(context).services.couleurs.primarySwatch[800],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Accueil
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name != "/accueil") {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/accueil"));
                Navigator.of(context).pushNamed("/accueil");
              }
            },
            color: InheritedServices.of(context)
                .services
                .couleurs
                .textColor
                .withOpacity(0.8),
            icon: const Icon(Icons.house_outlined)
          ),
          //Profil
          IconButton(
            onPressed: () {
              if (!ModalRoute.of(context)!.settings.name!.contains("/accueil/profil")) {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/accueil/profil"));
                Navigator.of(context).pushNamed("/accueil/profil");
              }
            },
            color: InheritedServices.of(context)
                .services
                .couleurs
                .textColor
                .withOpacity(0.8),
            icon: const Icon(Icons.person)
          ),
          //Amis
          IconButton(
            onPressed: () {
              if (ModalRoute.of(context)!.settings.name !=
                  "/accueil/friends") {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/accueil/friends"));
                Navigator.of(context).pushNamed("/accueil/friends");
              }
            },
            color: InheritedServices.of(context)
                .services
                .couleurs
                .textColor
                .withOpacity(0.8),
            icon: const Icon(Icons.people_sharp)
          ),
        ],
      ),
    );
  }
}
