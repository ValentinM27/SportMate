import 'package:flutter/material.dart';
import 'package:sportmate/logic/search_events.dart';
import 'package:sportmate/logic/search_friends.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Sport'Mate"),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          if(ModalRoute.of(context)!.settings.name != "/accueil/addEvent"){
            Navigator.of(context).pushNamed("/accueil/addEvent");
          }
        },
        icon: const Icon(Icons.add_box_outlined),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("Que voulez-vous rechercher ?"),
                  children: [
                    TextButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: SearchFriends()
                        );
                      },
                      child: const Text("Rechercher des amis")
                    ),
                    TextButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: SearchEvents()
                        );
                      },
                      child: const Text("Rechercher des évènements en fonction du sport"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: const [
                          Text("Annuler"),
                          Icon(Icons.cancel)
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.search)
        )
      ],
    );
  }
}
