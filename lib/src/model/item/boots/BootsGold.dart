import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class BootsGold extends Item {
  BootsGold()
      : super(
          ItemType.boots,
          'Gold Boots',
          'I chase nothing but wealth',
          [Boost(speed: 0.20, intelligence: 2)],
          Image.asset('assets/images/bootsgold.png', width: 60, height: 60),
          100,
        );
}