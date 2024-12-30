import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class BootsHardsocks extends Item {
  BootsHardsocks()
      : super(
          ItemType.boots,
          'Hardsocks',
          'These socks are hard, and they smell weird...',
          [Boost(speed: 1.15, dexterity: 8)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          125,
        );
}