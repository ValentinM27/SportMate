import 'package:flutter/material.dart';
import 'package:sportmate/logic/friend.dart';
import 'package:sportmate/logic/list_friends_value_notifier.dart';
import 'package:sportmate/screens/widgets/custom_appbar.dart';
import 'package:sportmate/screens/widgets/custom_bottombar.dart';
import 'package:sportmate/screens/widgets/friend_card.dart';
import 'package:sportmate/screens/widgets/friend_card_request.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  bool _request = false;
  final ListFriendsValueNotifier _listNotifier = ListFriendsValueNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width/2,
                    child: TextButton(
                      onPressed: () {
                        if(_request) {
                          setState(() {
                            _request = false;
                          });
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.textColor),
                        backgroundColor: _request ? MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.primarySwatch) : MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.primarySwatch[900]!)
                      ),
                      child: const Text('Tous'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width/2,
                    child: TextButton(
                      onPressed: () {
                        if(!_request){
                          setState(() {
                            _request = true;
                          });
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.textColor),
                        backgroundColor: !_request ? MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.primarySwatch) : MaterialStateProperty.all<Color>(InheritedServices.of(context).services.couleurs.primarySwatch[900]!)
                      ),
                      child: const Text('En attente'),
                    ),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: Builder(
              builder: (context) {
                if(_request){
                  //on construit une liste si on est dans les requêtes
                  Future<List<Friend>> list = InheritedServices.of(context).services.apis.friendApi.retrieveFriendRequest();

                  return FutureBuilder(
                    future: list,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        _listNotifier.valueNotifierRequest.value = snapshot.data as List<Friend>;

                        if(_listNotifier.valueNotifierRequest.value.isNotEmpty){
                          return ValueListenableBuilder(
                            valueListenable: _listNotifier.valueNotifierRequest,
                            builder: (context, value, child) {
                              return ListView.builder(
                                itemCount: _listNotifier.valueNotifierRequest.value.length,
                                itemBuilder: (context, index) {
                                  return FriendRequestCard(friend: _listNotifier.valueNotifierRequest.value[index], valueNotifier: _listNotifier, );
                                },
                              );
                            },
                          );
                        }else{
                          return Text(
                            "Vous n'avez pas de demande d'amis.",
                            style: TextStyle(
                                color: InheritedServices.of(context).services.couleurs.textColor
                            ),
                          );
                        }
                      }else if(snapshot.hasError){
                        return Text("Une erreur est survenu : ${snapshot.error}");
                      }else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                }else{
                  //on construit une liste si on est dans les amis
                  Future<List<Friend>> list = InheritedServices.of(context).services.apis.friendApi.retrieveListFriend();

                  return FutureBuilder(
                    future: list,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        _listNotifier.valueNotifierFriends.value = snapshot.data as List<Friend>;

                        if (_listNotifier.valueNotifierFriends.value.isNotEmpty) {
                          return ValueListenableBuilder(
                            valueListenable: _listNotifier.valueNotifierFriends,
                            builder: (context, value, child) {
                              return ListView.builder(
                                itemCount: _listNotifier.valueNotifierFriends.value.length,
                                itemBuilder: (context, index) {
                                  return FriendCard(friend: _listNotifier.valueNotifierFriends.value[index], valueNotifier: _listNotifier, );
                                },
                              );
                            },
                          );
                        }else{
                          return Text(
                            "Vous n'avez pas encore d'amis. Sortez donc un peu !",
                            style: TextStyle(
                              color: InheritedServices.of(context).services.couleurs.textColor
                            ),
                          );
                        }
                      }else if(snapshot.hasError){
                        return Text("Une erreur est survenue : ${snapshot.error}");
                      }else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                }
              },
            ),
          ),
        ]
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}