import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/Player.dart';
import 'package:flutter_project/src/model/entity/WeightedManager.dart';
import 'package:flutter_project/src/model/entity/monster/Monster.dart';
import 'package:flutter_project/src/model/entity/monster/Monsters.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemInterpreter.dart';
import 'package:flutter_project/src/providers/game/FightManager.dart';
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
  FightManager? fightManager;

  List<double> get speedBoostValues => _speedBoostValues;
  List<double> get speedFrequencyValues => _speedFrequencyValues;
  List<double> get expBoostValues => _expBoostValues;
  Player get player => _player;

  double get expGain =>
      totalSpeed * totalExpBoost;

  double get totalExpBoost =>
      _expBoostValues[_player.expBoost] + _player.intelligence * 0.01;
  
  double get totalSpeed =>
      _eSenseMovementProvider.speedMagnitude * totalSpeedBoost;

  double get totalSpeedBoost =>
      _speedBoostValues[_player.speedBoost] +
      (_player.dexterity * 0.01 +
      _player.getNamedBoostFromEquipped('speed'));

  GameDataProvider(ESenseMovementProvider eSenseMovementProvider) {
    loadPlayer('Player');
    _eSenseMovementProvider = eSenseMovementProvider;
    updateTimer();
  }

  void updateTimer() {
    _timer?.cancel();
    int sec = (1000 * _speedFrequencyValues[_player.speedFrequency]).toInt();
    _timer = Timer.periodic(Duration(milliseconds: sec), (timer) {
      addExperience(totalSpeed);
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
      _player.level = getLevel(_player.experience);
    } catch (e) {
      _player = Player();
      _player.level = getLevel(_player.experience);
      _storageManager.saveFile(_player.name, _player.toJson());
    }

    notifyListeners();
  }

  void savePlayer() {
    _storageManager.saveFile(_player.name, _player.toJson());
  }

  int getLevel(double experience) {
    int level = 0;

    if (experience >= _levels.values.last) {
      return _levels.length - 1;
    }

    for (int i = 0; i < _levels.length - 1; i++) {
      if (experience < _levels[i + 1]!) {
        level = i;
        break;
      }
    }
    return level;
  }

  int getExperience(int level) {
    return _levels.values.elementAt(level);
  }

  void addExperience(double experience) {
    _player.experience += experience * totalExpBoost;
    _player.level = getLevel(_player.experience);
    savePlayer();
    notifyListeners();
  }

  void addDabloons(int dabloons) {
    _player.dabloons += dabloons;
    savePlayer();
    notifyListeners();
  }

  int remainingExperienceForNextLevel() {
    int level = getLevel(_player.experience);
    return _levels[level]! - _player.experience.floor();
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

  void startFight() {
    List<Monster> availableMonsters =
        Monsters.values.fold<List<Monster>>([], (prev, element) {
      prev.add(element.monster);
      return prev;
    });

    int playerLevel = getLevel(_player.experience);

    for (var monster in availableMonsters) {
      int levelDifference = (playerLevel - monster.level).abs();
      double weightBoost = max(-0.5, 1 - (levelDifference / 2));
      monster.weight *= (1 + weightBoost);
    }

    Monster monster = WeightedManager().roll(0, availableMonsters) as Monster;

    fightManager = FightManager(_player, monster, this);
    notifyListeners();
  }

  void endFight(BuildContext context) {
    if (fightManager != null) {
      if (fightManager!.monster.health <= 0) {
        int exp = fightManager!.monster.experience;
        int dabloons = fightManager!.monster.level * Random().nextInt(5) +
            fightManager!.monster.level;
        Item? item = WeightedManager().roll(0, ItemInterpreter.items) as Item?;
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$exp EXP',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      Text('$dabloons Dabloons',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Builder(builder: (context) {
                        if (item != null) {
                          return Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 71, 71, 71),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    item.image,
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Text('Found ${item.name}!',
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      })
                    ],
                  ),
                  backgroundColor: Theme.of(context).primaryColorLight,
                ));
        if (item != null) {
          _player.addItem(item);
        }
        addExperience(fightManager!.monster.experience.toDouble());
        addDabloons(dabloons);
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Text('You lost! Try going for a walk',
                              textAlign: TextAlign.center)),
                    ],
                  ),
                  backgroundColor: Theme.of(context).primaryColorLight,
                ));
      }
      fightManager = null;
    }
    savePlayer();
    notifyListeners();
  }
}
