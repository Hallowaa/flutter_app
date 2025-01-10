import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class SwordWood extends Item {
  SwordWood()
      : super(
          ItemType.weapon,
          'Wood Sword',
          'This might cause splinters',
          [Boost(dexterity: 2, damage: 5)],
          Image.asset('assets/images/swordwood.png', width: 60, height: 60),
          500,
        );
}