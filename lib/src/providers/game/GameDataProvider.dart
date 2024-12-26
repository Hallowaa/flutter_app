import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_project/src/model/entity/player.dart';
import 'package:flutter_project/src/providers/movement/ESenseMovementProvider.dart';
import 'package:flutter_project/src/util/StorageManager.dart';

class GameDataProvider extends ChangeNotifier {
  Player _player = Player();
  final StorageManager _storageManager = StorageManager();
  final Map<int, int> _levels = {
    0: 0,
    1: 1000,
    2: 2000,
    3: 3500,
    4: 5000,
    5: 7000,
    6: 10000,
    7: 14000,
    8: 20000,
    9: 28000,
    10: 40000,
    11: 56000,
    12: 80000,
    13: 100000,
    14: 120000,
    15: 150000,
    16: 180000,
    17: 210000,
    18: 250000,
    19: 290000,
    20: 330000,
    21: 380000,
    22: 430000,
    23: 480000,
    24: 530000,
    25: 580000,
    26: 630000,
    27: 680000,
    28: 730000,
    29: 780000,
    30: 830000
  };

  Player get player => _player;

  GameDataProvider(ESenseMovementProvider eSenseMovementProvider) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int levelBefore = getLevel(_player.experience);
      addExperience(eSenseMovementProvider.deviceSpeedMagnitude.floor());
      int levelAfter = getLevel(_player.experience);

      if (levelAfter > levelBefore) {
        // show level up dialog
      }
    });
  }

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

  int getLevel(int experience) {
    int level = 0;
    for (int i = 0; i < _levels.length; i++) {
      if (experience < _levels[i]!) {
        level = i;
        break;
      }
    }
    return level;
  }

  void addExperience(int experience) {
    _player.experience += experience;
    savePlayer();
    notifyListeners();
  }
}