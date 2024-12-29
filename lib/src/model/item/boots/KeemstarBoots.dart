import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';

class KeemstarBoots extends Item {
  KeemstarBoots()
      : super(
          'Keemstar Boots',
          'Do you have any idea how fast I really am?',
          [Boost(dexterity: 10)],
          Image.asset('assets/images/missing.png'),
          10,
        );
}