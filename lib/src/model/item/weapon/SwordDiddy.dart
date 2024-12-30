import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class SwordDiddy extends Item {
  SwordDiddy()
      : super(
          ItemType.weapon,
          'Diddy Sword',
          'Oil up the sword and get ready to fight',
          [Boost(strength: 2, damage: 10)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          35,
        );
}