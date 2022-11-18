import 'package:flutter/material.dart';
import 'package:sportmate/logic/user.dart';
import 'package:sportmate/screens/widgets/card_user.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class SearchFriends extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future<dynamic> res = InheritedServices.of(context).services.apis.userApi.search(query);

    return FutureBuilder(
      future: res,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data.runtimeType == String){
            return Center(child : Text(snapshot.data as String));
          }else{
            List data = snapshot.data as List;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CardUser(user: User.fromJson(data[index]));
              },
            );
          }
        }else if(snapshot.hasError){
          return Center(child: Text("Une erreur est survenue, veuillez réessayer : ${snapshot.error} ${snapshot.stackTrace}"));
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
