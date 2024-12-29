import 'dart:convert';

import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemInterpreter.dart';

class Player {
  String name = 'Player';
  String password = '';
  double experience = 0;
  double dabloons = 0;
  final int _baseHealth = 100;
  final int _baseDamage = 10;
  int maxDamage = 15;

  // stats
  int _strength = 0;
  int _dexterity = 0;
  int _intelligence = 0;

  // passives
  int speedBoost = 0;
  int speedFrequency = 0;
  int expBoost = 0;

  List<Item> inventory = [];

  int get strength {
    return _strength +
        inventory.fold(
            0,
            (int previousValue, Item item) =>
                previousValue +
                item.boosts
                    .fold(0, (int prev, Boost boost) => prev + boost.strength));
  }

  int get dexterity {
    return _dexterity +
        inventory.fold(
            0,
            (int previousValue, Item item) =>
                previousValue +
                item.boosts.fold(
                    0, (int prev, Boost boost) => prev + boost.dexterity));
  }

  int get intelligence {
    return _intelligence +
        inventory.fold(
            0,
            (int previousValue, Item item) =>
                previousValue +
                item.boosts.fold(
                    0, (int prev, Boost boost) => prev + boost.intelligence));
  }

  int get health {
    return _baseHealth +
        inventory.fold(
            0,
            (int previousValue, Item item) =>
                previousValue +
                item.boosts.fold(
                    0, (int prev, Boost boost) => prev + boost.health));
  }

  int get damage {
   return _baseDamage +
        inventory.fold(
            0,
            (int previousValue, Item item) =>
                previousValue +
                item.boosts.fold(
                    0, (int prev, Boost boost) => prev + boost.damage));
  }

  Player();

  Player.fromJson(dynamic json) {
    name = json['name'] ?? 'Player';
    password = json['password'] ?? '';
    experience = json['experience'] ?? 0;

    _strength = json['strength'] ?? 0;
    _dexterity = json['dexterity'] ?? 0;
    _intelligence = json['intelligence'] ?? 0;

    speedBoost = json['speedBoost'] ?? 0;
    speedFrequency = json['speedFrequency'] ?? 0;
    expBoost = json['expBoost'] ?? 0;

    inventory = json['inventory'] != null
        ? json['inventory']
            .map<Item>((item) => ItemInterpreter.getItem(item))
            .toList()
        : [];
  }

  String toJson() {
    return json.encode({
      'name': name,
      'password': password,
      'experience': experience,
      'strength': _strength,
      'dexterity': _dexterity,
      'intelligence': _intelligence,
      'speedBoost': speedBoost,
      'speedFrequency': speedFrequency,
      'expBoost': expBoost,
      'inventory': inventory.map((item) => ItemInterpreter.getId(item)).toList(),
    });
  }
}
