import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class SwordNeutral extends Item {
  SwordNeutral()
      : super(
          ItemType.weapon,
          'Neutral Sword',
          'Prepare the sword for battle',
          [Boost(strength: 2, damage: 10)],
          Image.asset('assets/images/swordneutral.png', width: 60, height: 60),
          375,
        );
}
