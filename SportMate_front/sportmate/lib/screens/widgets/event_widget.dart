import 'package:flutter/material.dart';
import 'package:sportmate/logic/event.dart';
import 'package:sportmate/screens/pages/event_info.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class EventWidget extends StatefulWidget {
  final Event event;

  const EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  get ts => TextStyle(
    color: InheritedServices.of(context).services.couleurs.textColor.withAlpha(240),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.event.idEvent != null){
          showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return EventInfo(event: widget.event);
            },
          );
        }
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.elliptical(85, 50))
        ),
        color: const Color(0xff3b3b3b),
        elevation: 15,
        child: Column(
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
            )
          ],
        )
      ),
    );
  }
}
