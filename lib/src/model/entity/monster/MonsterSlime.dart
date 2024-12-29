import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/monster/Monster.dart';

class MonsterSlime extends Monster {
  MonsterSlime()
      : super(
          'Slime',
          50,
          8,
          16,
          150,
          1,
          Image.asset('assets/images/slime.png'),
          400,
        );
}