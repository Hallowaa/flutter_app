import 'dart:convert';

class Player {
  String name = 'Player';
  int experience = 0;

  Player();

  Player.fromJson(dynamic json) {
    name = json['name'] ?? 'Player';
    experience = json['experience'] ?? 0;
  }

  String toJson() {
    return json.encode({
      'name': name,
      'experience': experience,
    });
  }
}
