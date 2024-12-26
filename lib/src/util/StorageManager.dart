import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';


class StorageManager {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> loadFile(String name) async {
    final path = await _localPath;

    return File('$path/$name');
  }

  Future<String> readFileAsString(String name) async {
    final file = await loadFile(name);

    return file.readAsStringSync();
  }

  Future<dynamic> readFileAsJson(String name) async {
    final file = await loadFile(name);

    final data = file.readAsStringSync();

    return json.decode(data);
  }


  Future<File> saveFile(String name, String data) async {
    final file = await loadFile(name);

    // if file does not exist, create it
    if (!file.existsSync()) {
      file.createSync();
    }

    return file.writeAsString(data);
  }

}