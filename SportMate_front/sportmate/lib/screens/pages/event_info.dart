import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sportmate/logic/comment.dart';
import 'package:sportmate/logic/event.dart';
import 'package:sportmate/logic/mail.dart';
import 'package:sportmate/screens/widgets/comment_card.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class EventInfo extends StatefulWidget {
  final Event event;

  const EventInfo({Key? key, required this.event}) : super(key: key);

  @override
  _EventInfoState createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  get ts => TextStyle(
    color: InheritedServices.of(context).services.couleurs.textColor.withAlpha(240),
  );
  final TextEditingController _comment = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    setState(() {});
    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: AppBar(
        title: const Text("Détails"),
        centerTitle: true,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Créateur : ${widget.event.firstName} ${widget.event.lastName}",
                style: ts,
              ),
              subtitle: Text(
                "Crée le : ${widget.event.dateCreation!.day}/${widget.event.dateCreation!.month}/${widget.event.dateCreation!.year}",
                style: ts,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "${widget.event.desc}",
                    textAlign: TextAlign.justify,
                    style: ts,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "| Nombre de personnes minimum : ${widget.event.persMin ?? "0"}\n| Nombre de personnes maximum : ${widget.event.persMax ?? "aucune limite"}",
                      textAlign: TextAlign.left,
                      style: ts,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "| ${widget.event.label} | ${widget.event.typeEvent.toString().split(".")[1]}",
                      textAlign: TextAlign.left,
                      style: ts,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "| Le ${widget.event.dateEvent!.day}/${widget.event.dateEvent!.month}/${widget.event.dateEvent!.year}",
                      textAlign: TextAlign.left,
                      style: ts,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                    future: InheritedServices.of(context).services.apis.joinApi.participate(widget.event.idEvent!),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        if(snapshot.data == true){
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                InheritedServices.of(context).services.apis.joinApi.leaveEvent(widget.event.idEvent!);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Vous avez quitté l'évènement"),
                                  behavior: SnackBarBehavior.floating
                                ));
                              });
                            },
                            child: const Text("Quitter")
                          );
                        }else{
                          return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  InheritedServices.of(context).services.apis.joinApi.joinEvent(widget.event.idEvent!);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Vous avez rejoint l'évènement"),
                                    behavior: SnackBarBehavior.floating
                                  ));
                                });
                              },
                              child: const Text("Rejoindre")
                          );
                        }
                      }else if(snapshot.hasError){
                        return Text("Une erreur est survenue : ${snapshot.error} ${snapshot.stackTrace}");
                      }else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                    future: Mail.readMail(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        if(widget.event.mail == snapshot.data){
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                InheritedServices.of(context).services.apis.eventApi.deleteEvent(widget.event.idEvent!);
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text("Supprimer")
                          );
                        }else{
                          return const SizedBox.shrink();
                        }
                      }else if(snapshot.hasError){
                        return Text("Une erreur est survenue : ${snapshot.error} ${snapshot.stackTrace}");
                      }else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: null,
                            controller: _comment,
                            maxLength: 255,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Laissez un commentaire",
                              labelStyle: TextStyle(
                                color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                              ),
                              helperStyle: TextStyle(
                                color: InheritedServices.of(context).services.couleurs.textColor.withOpacity(0.4),
                              ),
                            ),
                            style: ts,
                            cursorColor: InheritedServices.of(context).services.couleurs.textColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24, left: 8, right: 8),
                          child: ElevatedButton(
                            onPressed: () async {
                              String mail = await Mail.readMail();
                              Comment comm = Comment(
                                eMail: mail,
                                idComm: null,
                                idEvent: widget.event.idEvent,
                                commentContent: _comment.text,
                                firstName: null,
                                lastName: null,
                              );

                              _comment.clear();

                              InheritedServices.of(context).services.apis.commentApi.createComment(comm);

                              setState(() {});
                            },
                            child: Icon(Icons.send, color: InheritedServices.of(context).services.couleurs.textColor)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                  future: InheritedServices.of(context).services.apis.commentApi.retrieveComment(widget.event.idEvent!),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List<Comment> list = snapshot.data as List<Comment>;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return CommentCard(comment: list[index]);
                        },
                      );
                    }else if(snapshot.hasError) {
                      return Text("Une erreur est survenue ${snapshot.error}\n${snapshot.stackTrace}", style: ts);
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }
}
