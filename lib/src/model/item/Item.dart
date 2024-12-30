import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/Weighted.dart';
import 'package:flutter_project/src/model/item/Boost.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

abstract class Item extends Weighted {
  Itemtype type = Itemtype.unset;
  String name = '';
  String description = '';
  List<Boost> boosts = [];
  Image image = Image.asset('assets/images/missing.png', width: 60, height: 60);
  bool equipped = false;
  int quantity = 1;

  Item(this.type, this.name, this.description, this.boosts, this.image,
      double weight)
      : super(weight);

  double getTotalBoost(String name) {
    return boosts.fold(0, (prev, boost) => prev + boost.getNamed(name));
  }

  List<String> getAllStatNames() {
    return [
      'strength',
      'dexterity',
      'intelligence',
      'health',
      'damage',
      'speed',
      'frequency',
      'experience'
    ];
  }
}
