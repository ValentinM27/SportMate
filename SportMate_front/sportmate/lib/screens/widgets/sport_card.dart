import 'package:flutter/material.dart';
import 'package:sportmate/logic/practice.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class SportCard extends StatefulWidget {
  final Practice practice;
  final Map<int, bool> areSelected;
  final Function(bool, int) onSelected;
  final int numberSelected;

  SportCard({Key? key, required this.practice, required this.areSelected, required this.onSelected, required this.numberSelected}) : super(key: key);

  @override
  _SportCardState createState() => _SportCardState();
}

class _SportCardState extends State<SportCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if(widget.areSelected[widget.practice.idSport!]!){
            widget.areSelected[widget.practice.idSport!] = false;
            widget.onSelected(widget.areSelected[widget.practice.idSport!]!, widget.practice.idSport!);
          }else if(widget.numberSelected < 5){
            widget.areSelected[widget.practice.idSport!] = true;
            widget.onSelected(widget.areSelected[widget.practice.idSport!]!, widget.practice.idSport!);
          }
        });
      },
      child: Card(
        color: widget.areSelected[widget.practice.idSport!]! ? InheritedServices.of(context).services.couleurs.primarySwatch[900] : InheritedServices.of(context).services.couleurs.textColor,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.practice.label!,
            textAlign: TextAlign.center,
          )
        ),
      ),
    );
  }
}
