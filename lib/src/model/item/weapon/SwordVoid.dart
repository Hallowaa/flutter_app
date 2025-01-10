import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class SwordVoid extends Item {
  SwordVoid()
      : super(
          ItemType.weapon,
          'Void Sword',
          'The void is calling',
          [Boost(strength: 4, dexterity: 4, intelligence: 2, damage: 25, health: -30)],
          Image.asset('assets/images/swordvoid.png', width: 60, height: 60),
          200,
        );
}