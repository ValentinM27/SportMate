import 'package:flutter/material.dart';
import 'package:sportmate/logic/event.dart';
import 'package:sportmate/screens/widgets/event_widget.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class SearchEvents extends SearchDelegate{
  Map<int, String> dataFromQuery = {};

  @override
  Widget buildSuggestions(BuildContext context) {
    return Builder(
      builder: (context) {
        if(dataFromQuery.isEmpty){
          InheritedServices.of(context).services.sportEnum.getSports();
          dataFromQuery = InheritedServices.of(context).services.sportEnum.sports;
        }

        List<int> toRemove = [];

        dataFromQuery.forEach((key, value) {
          if(query != "" && !value.startsWith(query.toUpperCase())){
            toRemove.add(key);
          }
        });

        for (int element in toRemove) {dataFromQuery.remove(element);}

        if(query.isEmpty){
          dataFromQuery = InheritedServices.of(context).services.sportEnum.sports;
        }

        return ListView.builder(
          itemCount: dataFromQuery.values.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dataFromQuery.values.elementAt(index)),
              onTap: () {
                query = dataFromQuery.values.elementAt(index);
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
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
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    int idSport = InheritedServices.of(context).services.sportEnum.getIdSportFromQuery(query);

    Future<List<Event>> res = InheritedServices.of(context).services.apis.eventApi.retrieveEventBySport(idSport);

    return FutureBuilder(
      future: res,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List<Event> events = snapshot.data as List<Event>;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventWidget(event: events[index]);
            },
          );
        }else if(snapshot.hasError){
          return Center(child: Text("Une erreur est survenue : ${snapshot.error}"));
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}