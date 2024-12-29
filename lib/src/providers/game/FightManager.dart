import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/Player.dart';
import 'package:flutter_project/src/model/entity/monster/Monster.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';

class FightManager {
  final Player _player;
  final Monster _monster;
  bool done = false;
  int playerHealth = 0;
  int monsterMaxHealth = 0;
  List<dynamic> entities = [];
  List<String> logs = [];
  int turn = 0;
  final GameDataProvider _gp;

  Monster get monster => _monster;

  FightManager(this._player, this._monster,  this._gp) {
    entities = [_player, _monster];
    playerHealth = _player.health;
    monsterMaxHealth = _monster.health;
  }

  void doTurn(BuildContext context) {
    done = playerHealth <= 0 || monster.health <= 0;

    if (done) {
      _gp.endFight(context);
      return;
    }

    if (entities[turn] is Player) {
      _playerAttack();
    } else {
      _monsterAttack();
    }
    turn = (turn + 1) % 2;

    // if monster, do automatic turn
    if (entities[turn] is Monster) {
      doTurn(context);
    }
  }

  void _playerAttack() {
    int damage = _gp.rollDamage();
    _monster.takeDamage(damage);
    logs.add("${_player.name} hit ${_monster.name} for $damage damage!");
  }

  void _monsterAttack() {
    int damage = _monster.damage;
    playerHealth -= damage;
    logs.add("${_monster.name} hit ${_player.name} for $damage damage!");
  }
}