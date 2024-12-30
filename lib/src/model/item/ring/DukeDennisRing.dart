import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class DukeDennisRing extends Item {
  DukeDennisRing()
      : super(
          Itemtype.ring,
          'Duke Dennis Ring',
          'A ring that gives you the power of Duke Dennis',
          [Boost(intelligence: 3)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          40,
        );
}