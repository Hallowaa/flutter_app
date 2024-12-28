import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/monster/Monster.dart';

class MonsterGoblin extends Monster {
  MonsterGoblin()
      : super(
          'Goblin',
          70,
          10,
          200,
          2,
          Image.asset('assets/images/goblin.png'),
          100,
        );
}