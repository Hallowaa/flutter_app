import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class BootsLeather extends Item {
  BootsLeather()
      : super(
          ItemType.boots,
          'Leather Boots',
          'Walking! Now without the pain',
          [Boost(speed: 0.15, strength: 3)],
          Image.asset('assets/images/bootsleather.png', width: 60, height: 60),
          200,
        );
}