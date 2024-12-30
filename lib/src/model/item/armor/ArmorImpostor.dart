import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class ArmorImpostor extends Item {
  ArmorImpostor()
      : super(
          ItemType.armor,
          'Impostor Armor',
          'STOP POSTING ABOUT AMONG US',
          [Boost(health: 50)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          75,
        );
}