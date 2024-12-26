import 'dart:convert';

class Player {
  String name = 'Player';
  String password = '';
  int experience = 0;

  Player();

  Player.fromJson(dynamic json) {
    name = json['name'] ?? 'Player';
    password = json['password'] ?? '';
    experience = json['experience'] ?? 0;
  }

  String toJson() {
    return json.encode({
      'name': name,
      'password': password,
      'experience': experience,
    });
  }
}
