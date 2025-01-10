import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class ArmorGold extends Item {
  ArmorGold()
      : super(
          ItemType.armor,
          'Gold Armor',
          'Greed propels you',
          [Boost(health: 60, dexterity: -1, intelligence: 3)],
          Image.asset('assets/images/armorgold.png', width: 60, height: 60),
          200,
        );
}