import 'package:flutter/material.dart';

class DialogBuilder extends StatelessWidget {
  final String message;
  const DialogBuilder({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: const Color(0xFF2E3532),
      children : [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                message,
                style: const TextStyle(
                    color: Color(0xFFE0E2DB)
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) {
                  return route.settings.name == "/";
                });
              },
              child: const Text("OK !")
            )
          ]
        ),
      ]
    );
  }
}
