import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class ArmorIron extends Item {
  ArmorIron()
      : super(
          ItemType.armor,
          'Iron Armor',
          'Every game has this',
          [Boost(health: 50)],
          Image.asset('assets/images/armoriron.png', width: 60, height: 60),
          450,
        );
}