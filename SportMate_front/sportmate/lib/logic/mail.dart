import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Classe permettant de stocker le mail
class Mail{
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/mail.txt');
  }

  /// Ecriture du mail
  static Future<File> writeMail(String mail) async {
    final file = await _localFile;
    return file.writeAsString(mail);
  }

  /// Lecture du mail
  static Future<String> readMail() async {
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

  /// Effaçage du mail
  static erase() async{
    final file = await _localFile;
    return file.writeAsString("");
  }
}