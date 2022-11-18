import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Classe permettant de stocker le token
class Token{
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/token.txt');
  }

  /// Ecriture du token
  static Future<File> writeToken(String token) async {
    final file = await _localFile;
    return file.writeAsString(token);
  }

  /// Lecture du token
  static Future<String> readToken() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return "ERROR"
      return "ERROR";
    }
  }

  /// Effaçage du token
  static erase() async{
    final file = await _localFile;
    return file.writeAsString("");
  }
}