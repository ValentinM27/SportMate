import 'package:flutter/material.dart';
import 'package:sportmate/logic/practice.dart';
import 'package:sportmate/screens/widgets/custom_appbar.dart';
import 'package:sportmate/screens/widgets/custom_bottombar.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';
import 'package:sportmate/screens/widgets/sport_card.dart';

class SportPratique extends StatefulWidget {
  const SportPratique({Key? key}) : super(key: key);

  @override
  _SportPratiqueState createState() => _SportPratiqueState();
}

class _SportPratiqueState extends State<SportPratique> {
  final List<int> sports = [];
  int numberSelected = 0;
  final Map<int, bool> areSelected = <int, bool>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
      appBar: CustomAppBar(),
      bottomNavigationBar: const CustomBottomBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: InheritedServices.of(context).services.sportEnum.sports.length,
              itemBuilder: (context, index) {
                areSelected.putIfAbsent(index, () => false);

                if (index == 0) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Vous devez choisir les sports que vous pratiquez. 5 au maximum, nbSelected : $numberSelected",
                      style: TextStyle(
                        color: InheritedServices.of(context).services.couleurs.textColor
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  //areSelected.value[index] = false;

                  return SportCard(
                    numberSelected: numberSelected,
                    onSelected: (bool res, int idSport) {
                      setState(() {
                        if(res){
                          numberSelected++;
                          sports.add(idSport);
                        }else{
                          numberSelected--;
                          sports.remove(idSport);
                        }
                      });
                    },
                    areSelected: areSelected,
                    practice: Practice(
                      idSport: index,
                      label: InheritedServices.of(context).services.sportEnum.sports[index]
                    ),
                  );
                }
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                List<Practice> practices = await InheritedServices.of(context).services.apis.practiceApi.retrievePractices();

                if(practices.isNotEmpty && practices[0].label != "ERROR"){
                  for (var element in practices) {
                    var rep = await InheritedServices.of(context).services.apis.practiceApi.deletePractice(element.idSport!);
                  }
                }

                if(sports.isNotEmpty){
                  for(var element in sports){
                    InheritedServices.of(context).services.apis.practiceApi.setPractice(element);
                  }
                }

                Navigator.of(context).pop();
              },
              child: const Text('Valider'),
              style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(400)))),
            ),
          )
        ],
      ),
    );
  }
}
