import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class GlizzySword extends Item {
  GlizzySword()
      : super(
          Itemtype.weapon,
          'Glizzy Sword',
          'A sword made of glizzy',
          [Boost(dexterity: 2, damage: 5)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          50,
        );
}