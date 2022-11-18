import 'package:flutter/material.dart';
import 'package:sportmate/logic/friend.dart';
import 'package:sportmate/logic/list_friends_value_notifier.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class FriendRequestCard extends StatefulWidget{
  final Friend friend;
  final ListFriendsValueNotifier valueNotifier;

  const FriendRequestCard({Key? key, required this.friend, required this.valueNotifier}) : super(key: key);

  @override
  _FriendRequestCardState createState() => _FriendRequestCardState();
}

class _FriendRequestCardState extends State<FriendRequestCard> {
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('Accepter'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.textColor),
                  backgroundColor: MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.bgColor)
                ),
                onPressed: () {
                  InheritedServices.of(context).services.apis.friendApi.validateFriendship(widget.friend.idFriendship!);
                  widget.valueNotifier.valueNotifierRequest.value.remove(widget.friend);
                  widget.valueNotifier.valueNotifierRequest.notifyListeners();
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Refuser'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.textColor),
                  backgroundColor: MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.bgColor)
                ),
                onPressed: () {
                  InheritedServices.of(context).services.apis.friendApi.deleteFriendship(widget.friend.idFriendship!);
                  widget.valueNotifier.valueNotifierRequest.value.remove(widget.friend);
                  widget.valueNotifier.valueNotifierRequest.notifyListeners();
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
