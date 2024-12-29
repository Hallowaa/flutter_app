import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/monster/Monster.dart';

enum Monsters {
  slime,
  goblin,
  wolf,
  ghost
}

extension MonsterExtension on Monsters {
  Monster get monster {
    switch (this) {
      case Monsters.slime:
        return Monster(
          'Slime',
          50,
          8,
          16,
          25,
          1,
          Image.asset('assets/images/slime.png'),
          400,
        );
      case Monsters.goblin:
        return Monster(
          'Goblin',
          70,
          10,
          20,
          50,
          2,
          Image.asset('assets/images/goblin.png'),
          200,
        );
      case Monsters.wolf:
        return Monster(
          'Wolf',
          140,
          20,
          25,
          75,
          3,
          Image.asset('assets/images/wolf.png'),
          130,
        );
      case Monsters.ghost:
        return Monster(
          'Ghost',
          180,
          25,
          30,
          100,
          4,
          Image.asset('assets/images/missing.png'),
          100,
        );
    }
  }
}