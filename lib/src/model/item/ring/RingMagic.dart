import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class RingMagic extends Item {
  RingMagic()
      : super(
          ItemType.ring,
          'Magic Ring',
          'No more mage seekers!',
          [Boost(intelligence: 3)],
          Image.asset('assets/images/ringmagic.png', width: 60, height: 60),
          250,
        );
}