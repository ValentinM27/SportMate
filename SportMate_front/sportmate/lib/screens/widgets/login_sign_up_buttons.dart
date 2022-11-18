import 'package:flutter/material.dart';

class Buttons extends StatefulWidget{
  const Buttons({Key? key}) : super(key: key);

  @override
  _Buttons createState() => _Buttons();
}

class _Buttons extends State<Buttons>{


  @override
  Widget build(BuildContext context) {
    Widget _signUpButton(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed : () => {
              Navigator.of(context).pushNamed("/signup")
            },
            child: const Text("Inscription", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(400)
                )
              )
            ),
          ),
        ],
      );
    }

    Widget _loginButton(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => {
              Navigator.of(context).pushNamed("/login")
            },
            child: const Text("Connexion", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>
              (
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(400)
                )
              )
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _signUpButton(context),
        _loginButton(context)
      ],
    );
  }
}