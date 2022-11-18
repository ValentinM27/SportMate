import 'package:flutter/material.dart';
import 'package:sportmate/logic/service.dart';
import 'package:sportmate/logic/user.dart';
import 'package:sportmate/screens/pages/accueil.dart';
import 'package:sportmate/screens/pages/add_event.dart';
import 'package:sportmate/screens/pages/forgot_password.dart';
import 'package:sportmate/screens/pages/friends_list.dart';
import 'package:sportmate/screens/pages/login_form.dart';
import 'package:sportmate/screens/pages/not_connected_page.dart';
import 'package:sportmate/screens/pages/profil.dart';
import 'package:sportmate/screens/pages/signup_form_basic.dart';
import 'package:sportmate/screens/pages/signup_form_details.dart';
import 'package:sportmate/screens/pages/sport_pratique.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

void main() {
  runApp(InheritedServices(services: Service(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => const NotConnectedPage(),
        '/signup': (context) => const SignUpFormBasic(),
        "/signup/details": (context) => SignUpFormDetails(user: ModalRoute.of(context)!.settings.arguments as User),
        "/login": (context) => const LoginForm(),
        "/login/reset": (context) => const ForgotPasswordPage(),
        "/accueil": (context) => const Accueil(),
        "/accueil/addEvent": (context) => AddEventPage(),
        "/accueil/profil": (context) => const Profil(),
        "/accueil/profil/pratique": (context) => const SportPratique(),
        "/accueil/friends": (context) => const FriendsList(),

      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return InheritedServices(
                services: Service(),
                child: Scaffold(
                  appBar:
                      AppBar(title: const Text("Erreur 404"), centerTitle: true),
                  body: Column(
                    children: [
                      const Expanded(child: Center(child: Text("Page non trouvé"))),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popUntil(ModalRoute.withName("/accueil"));
                            Navigator.of(context).pushNamed("/accueil");
                          },
                          child: const Text('Revenir à l\'accueil'),
                        ),
                      )
                    ],
                  )));
          },
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: InheritedServices.of(context).services.couleurs.primarySwatch,
        backgroundColor: InheritedServices.of(context).services.couleurs.bgColor,
        scaffoldBackgroundColor: InheritedServices.of(context).services.couleurs.textColor,
        dialogBackgroundColor: InheritedServices.of(context).services.couleurs.textColor,
      ),
    );
  }
}
