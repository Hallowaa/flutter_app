import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/Weighted.dart';
import 'package:flutter_project/src/model/item/Boost.dart';

abstract class Item extends Weighted {
  String name = '';
  String description = '';
  List<Boost> boosts = [];
  Image image = Image.asset('assets/images/perandus.png');
  bool equipped = false;

  Item(this.name, this.description, this.boosts, this.image, int weight) : super(weight);
}