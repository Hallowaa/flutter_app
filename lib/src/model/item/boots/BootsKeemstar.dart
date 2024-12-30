import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class BootsKeemstar extends Item {
  BootsKeemstar()
      : super(
          ItemType.boots,
          'Keemstar Boots',
          'Do you have any idea how fast I really am?',
          [Boost(dexterity: 10)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          10,
        );
}