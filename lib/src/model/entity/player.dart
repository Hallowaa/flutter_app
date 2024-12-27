import 'dart:convert';

class Player {
  String name = 'Player';
  String password = '';
  double experience = 0;
  double dabloons = 0;
  int baseHealth = 100;
  int baseDamage = 10;

  // stats
  int strength = 0;
  int dexterity = 0;
  int intelligence = 0;

  // passives
  int speedBoost = 0;
  int speedFrequency = 0;
  int expBoost = 0;

  Player();

  Player.fromJson(dynamic json) {
    name = json['name'] ?? 'Player';
    password = json['password'] ?? '';
    experience = json['experience'] ?? 0;

    strength = json['strength'] ?? 0;
    dexterity = json['dexterity'] ?? 0;
    intelligence = json['intelligence'] ?? 0;

    speedBoost = json['speedBoost'] ?? 0;
    speedFrequency = json['speedFrequency'] ?? 0;
    expBoost = json['expBoost'] ?? 0;
  }

  String toJson() {
    return json.encode({
      'name': name,
      'password': password,
      'experience': experience,
      'strength': strength,
      'dexterity': dexterity,
      'intelligence': intelligence,
      'speedBoost': speedBoost,
      'speedFrequency': speedFrequency,
      'expBoost': expBoost,
    });
  }
}
