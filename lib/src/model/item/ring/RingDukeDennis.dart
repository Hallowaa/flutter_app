import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class RingDukeDennis extends Item {
  RingDukeDennis()
      : super(
          ItemType.ring,
          'Duke Dennis Ring',
          'Duke Dennis is the best 2k player',
          [Boost(intelligence: 3)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          250,
        );
}