import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class RingEpstein extends Item {
  RingEpstein()
      : super(
          ItemType.ring,
          'Epstein Ring',
          'Epstein did not kill himself',
          [Boost(intelligence: 6)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          150,
        );
}