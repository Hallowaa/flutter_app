import 'package:flutter/foundation.dart';
import 'package:flutter_project/src/model/entity/player.dart';
import 'package:flutter_project/src/util/StorageManager.dart';

class GameDataProvider extends ChangeNotifier {
  Player _player = Player();
  final StorageManager _storageManager = StorageManager();

  Player get player => _player;

  set player(Player player) {
    _player = player;
    notifyListeners();
  }

  void loadPlayer(String name) async {
    try {
      final player = await _storageManager.readFileAsJson(name);
      _player = Player.fromJson(player);
    } catch (e) {
      _player = Player();
      _player.name = name;
      _storageManager.saveFile(_player.name, _player.toJson());
    }
    
    notifyListeners();
  }

  void savePlayer() {
    _storageManager.saveFile(_player.name, _player.toJson());
  }


}