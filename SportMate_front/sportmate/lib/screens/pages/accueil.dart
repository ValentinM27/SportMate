import 'package:flutter/material.dart';
import 'package:sportmate/logic/event.dart';
import 'package:sportmate/screens/widgets/custom_appbar.dart';
import 'package:sportmate/screens/widgets/custom_bottombar.dart';
import 'package:sportmate/screens/widgets/event_widget.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Page d'accueil de l'application qui contient les evenements
class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    setState(() {});
    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {
    final Future<List<Event>> e = InheritedServices.of(context).services.apis.eventApi.retrieveEventByFriendsList();
    InheritedServices.of(context).services.sportEnum.getSports();


    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: e,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<Event> events = snapshot.data as List<Event>;
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: _onRefresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventWidget(
                    event: events[index]
                  );
                },
              ),
            );
          }else if(snapshot.hasError){
            return Text("Erreur lors de la récupération des données : ${snapshot.error.toString()}\n${snapshot.stackTrace}");
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
