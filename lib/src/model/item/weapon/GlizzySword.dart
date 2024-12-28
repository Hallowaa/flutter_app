import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';

class GlizzySword extends Item {
  GlizzySword()
      : super(
          'Glizzy Sword',
          'A sword made of glizzy',
          [Boost(dexterity: 2, damage: 5)],
          Image.asset('assets/images/glizzy_sword.png'),
          50,
        );
}