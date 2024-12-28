import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_project/src/model/entity/Player.dart';
import 'package:flutter_project/src/providers/movement/ESenseMovementProvider.dart';
import 'package:flutter_project/src/util/StorageManager.dart';

class GameDataProvider extends ChangeNotifier {
  Player _player = Player();
  final StorageManager _storageManager = StorageManager();
  Timer? _timer;
  late ESenseMovementProvider _eSenseMovementProvider;
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

  final List<double> _speedBoostValues = [1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2];
  final List<double> _speedFrequencyValues = [1.0, 0.9, 0.8, 0.7, 0.6, 0.5];
  final List<double> _expBoostValues = [1.0, 1.1, 1.2, 1.4, 1.6, 1.8, 2.0];

  int healthPerLevel = 30;
  int damagePerLevel = 4;

  List<double> get speedBoostValues => _speedBoostValues;
  List<double> get speedFrequencyValues => _speedFrequencyValues;
  List<double> get expBoostValues => _expBoostValues;
  Player get player => _player;

  GameDataProvider(ESenseMovementProvider eSenseMovementProvider) {
    loadPlayer('default');
    _eSenseMovementProvider = eSenseMovementProvider;
    updateTimer();
  }

  void updateTimer() {
    _timer?.cancel();
    int sec = (1000 * _speedFrequencyValues[_player.speedFrequency]).toInt();
    _timer = Timer.periodic(Duration(milliseconds: sec), (timer) {
      addExperience(_eSenseMovementProvider.deviceSpeedMagnitude * _speedBoostValues[_player.speedBoost]);
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

  int getLevel(double experience) {
    int level = 0;
    for (int i = 0; i < _levels.length - 1; i++) {
      if (experience < _levels[i + 1]!) {
        level = i;
        break;
      }
    }
    return level;
  }

  int getExperience(int level) {
    return _levels[level]!;
  }

  void addExperience(double experience) {
    _player.experience += experience * _expBoostValues[_player.expBoost].toInt();
    savePlayer();
    notifyListeners();
  }

  int remainingExperienceForNextLevel() {
    int level = getLevel(_player.experience);
    return _levels[level]! - _player.experience.floor();
  }

  int remainingPassivePoints() {
    return getLevel(_player.experience) - _player.strength - _player.dexterity - _player.intelligence - _player.speedBoost - _player.speedFrequency - _player.expBoost;
  }

  void upgradeSpeed() {
    _player.speedBoost++;
    updateTimer();
    notifyListeners();
  }

  void upgradeFrequency() {
    _player.speedFrequency++;
    updateTimer();
    notifyListeners();
  }

  void upgradeExp() {
    _player.expBoost++;
    notifyListeners();
  }

  int getHealth() {
    return _player.health + healthPerLevel * getLevel(_player.experience);
  }

  int getDamage() {
    return _player.damage + damagePerLevel * getLevel(_player.experience);
  }
}