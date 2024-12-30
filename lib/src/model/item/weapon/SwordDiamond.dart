import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class SwordDiamond extends Item {
  SwordDiamond()
      : super(
          ItemType.weapon,
          'Diamond Sword',
          'Steve would be proud',
          [Boost(strength: 5, dexterity: 3, intelligence: 1, damage: 35)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          25,
        );
}