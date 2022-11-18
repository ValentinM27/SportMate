import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Classe permettant de stocker le bool
class Remember{
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/bool.txt');
  }

  /// Ecriture du bool
  static Future<File> writeBool(bool boolean) async {
    final file = await _localFile;
    return file.writeAsString(boolean.toString());
  }

  /// Lecture du bool
  static Future<bool> readBool() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      final bool b = contents == "true";

      return b;
    } catch (e) {
      // If encountering an error, return 0
      return false;
    }
  }

  /// Effaçage du bool
  static erase() async{
    final file = await _localFile;
    return file.writeAsString("");
  }
}