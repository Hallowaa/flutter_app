import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class RingGold extends Item {
  RingGold()
      : super(
          ItemType.ring,
          'Gold Ring',
          'I wear my wealth proudly',
          [Boost(intelligence: 6)],
          Image.asset('assets/images/ringgold.png', width: 60, height: 60),
          150,
        );
}