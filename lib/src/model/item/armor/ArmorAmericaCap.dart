import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class ArmorAmericaCap extends Item {
  ArmorAmericaCap()
      : super(
          ItemType.armor,
          'America Cap',
          'Make america great again',
          [Boost(health: 100, intelligence: -3)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          100,
        );
}