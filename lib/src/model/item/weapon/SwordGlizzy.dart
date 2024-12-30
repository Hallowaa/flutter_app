import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class SwordGlizzy extends Item {
  SwordGlizzy()
      : super(
          ItemType.weapon,
          'Glizzy Sword',
          'I know what you are... a glizzy gobbler',
          [Boost(dexterity: 2, damage: 5)],
          Image.asset('assets/images/missing.png', width: 60, height: 60),
          500,
        );
}