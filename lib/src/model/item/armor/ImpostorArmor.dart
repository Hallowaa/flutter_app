import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/Item.dart';

class ImpostorArmor extends Item {
  ImpostorArmor()
      : super(
          'Impostor Armor',
          'There might be an impostor among us',
          [Boost(health: 50)],
          Image.asset('assets/images/missing.png'),
          100,
        );
}