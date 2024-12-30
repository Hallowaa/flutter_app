import 'dart:convert';
import 'dart:math';

import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemInterpreter.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class Player {
  String name = 'Player';
  String password = '';
  int dabloons = 0;
  int baseHealth = 100;
  int baseDamage = 10;
  int extraDamage = 15;

  double experience = 0;
  int level = 0;
  int healthPerLevel = 30;
  int damagePerLevel = 4;

  // stats
  int _strength = 0;
  int _dexterity = 0;
  int _intelligence = 0;

  // passives
  int speedBoost = 0;
  int speedFrequency = 0;
  int expBoost = 0;

  Item? get weapon {
    for (Item item in inventory) {
      if (item.type == Itemtype.weapon && item.equipped) {
        return item;
      }
    }
    return null;
  }

  Item? get armor {
    for (Item item in inventory) {
      if (item.type == Itemtype.armor && item.equipped) {
        return item;
      }
    }
    return null;
  }

  Item? get ring {
    for (Item item in inventory) {
      if (item.type == Itemtype.ring && item.equipped) {
        return item;
      }
    }
    return null;
  }

  Item? get boots {
    for (Item item in inventory) {
      if (item.type == Itemtype.boots && item.equipped) {
        return item;
      }
    }
    return null;
  }

  List<Item> inventory = [];

  int get strength {
    int beforeItems = _strength;
    return beforeItems + getNamedBoostFromEquipped('strength').toInt();
  }

  int get dexterity {
    int beforeItems = _dexterity;
    return beforeItems + getNamedBoostFromEquipped('dexterity').toInt();
  }

  int get intelligence {
    int beforeItems = _intelligence;
    return beforeItems + getNamedBoostFromEquipped('intelligence').toInt();
  }

  int get damage {
    int beforeItems = baseDamage + damagePerLevel * level;
    return beforeItems + getNamedBoostFromEquipped('damage').toInt();
  }

  int get health {
    int beforeItems = baseHealth + healthPerLevel * level;
    return beforeItems + getNamedBoostFromEquipped('health').toInt();
  }

  int get remainingPassivePoints {
    return level - speedBoost - speedFrequency - expBoost;
  }

  Player();

  Player.fromJson(dynamic json) {
    name = json['name'] ?? 'Player';
    password = json['password'] ?? '';
    experience = json['experience'] ?? 0;
    dabloons = json['dabloons'] ?? 0;

    _strength = json['strength'] ?? 0;
    _dexterity = json['dexterity'] ?? 0;
    _intelligence = json['intelligence'] ?? 0;

    speedBoost = json['speedBoost'] ?? 0;
    speedFrequency = json['speedFrequency'] ?? 0;
    expBoost = json['expBoost'] ?? 0;

    inventory = json['inventory'] != null
        ? (json['inventory'] as List).map((item) {
            var itemId = item['id'];
            var quantity = item['quantity'];
            Item i = ItemInterpreter.getItem(itemId);
            i.quantity = quantity;
            return i;
          }).toList()
        : [];
    validateInventory();
  }

  String toJson() {
    return json.encode({
      'name': name,
      'password': password,
      'experience': experience,
      'dabloons': dabloons,
      'strength': _strength,
      'dexterity': _dexterity,
      'intelligence': _intelligence,
      'speedBoost': speedBoost,
      'speedFrequency': speedFrequency,
      'expBoost': expBoost,
      'inventory': inventory
          .map((item) =>
              {'id': ItemInterpreter.getId(item), 'quantity': item.quantity})
          .toList(),
    });
  }

  double getNamedBoostFromEquipped(String name) {
    double total = 0;
    total += weapon?.getTotalBoost(name) ?? 0;
    total += armor?.getTotalBoost(name) ?? 0;
    total += ring?.getTotalBoost(name) ?? 0;
    total += boots?.getTotalBoost(name) ?? 0;
    return total;
  }

  int rollDamage() {
    return damage + Random().nextInt(extraDamage);
  }

  void addItem(Item item) {
    for (Item i in inventory) {
      if (i.name == item.name) {
        i.quantity++;
        return;
      }
    }

    inventory.add(item);
  }

  void validateInventory() {
    inventory.removeWhere((element) => element.quantity <= 0);

    // go through each item, keeping track of duplicate entries. Remove the duplicate and increase the quantity of the original
    // iterate through inventory backwards to remove duplicates
    for (int i = inventory.length - 1; i >= 0; i--) {
      for (int j = i - 1; j >= 0; j--) {
        if (inventory[i].name == inventory[j].name) {
          inventory[j].quantity++;
          inventory.removeAt(i);
          break;
        }
      }
    }
  }
}
