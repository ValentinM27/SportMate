import 'package:flutter/material.dart';
import 'package:sportmate/logic/friend.dart';
import 'package:sportmate/logic/list_friends_value_notifier.dart';

import 'inherited_services.dart';

class FriendCard extends StatefulWidget {
  final Friend friend;
  final ListFriendsValueNotifier valueNotifier;

  const FriendCard({Key? key, required this.friend, required this.valueNotifier}) : super(key: key);

  @override
  _FriendCardState createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: InheritedServices.of(context).services.couleurs.primarySwatch[800],
        child: Column(
          children: [
            ListTile(
              title: Text(
                "${widget.friend.firstName} ${widget.friend.lastName}",
                style: TextStyle(
                    color: InheritedServices.of(context).services.couleurs.textColor
                ),
              ),
              subtitle: Text(
                "${widget.friend.email}",
                style: TextStyle(
                    color: InheritedServices.of(context).services.couleurs.textColor
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Supprimer des amis'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.textColor),
                      backgroundColor: MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.bgColor)
                  ),
                  onPressed: () {
                    InheritedServices.of(context).services.apis.friendApi.deleteFriendship(widget.friend.idFriendship!);
                    widget.valueNotifier.valueNotifierFriends.value.remove(widget.friend);
                    widget.valueNotifier.valueNotifierFriends.notifyListeners();
                  },
                ),
                const SizedBox(width: 8),
              ],
            )
          ],
        )
    );
  }
}
