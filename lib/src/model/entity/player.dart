class Player {
  String name = 'Player';
  int experience = 0;

  Player({this.name = 'Player', this.experience = 0});

  Player.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? 'Player';
    experience = json['experience'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['score'] = experience;
    return data;
  }
}
