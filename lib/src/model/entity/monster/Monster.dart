import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/Weighted.dart';

abstract class Monster extends Weighted {
  String name = '';
  int health = 0;
  int damage = 0;
  int experience = 0;
  int level = 0;
  Image image = Image.asset('assets/images/perandus.png');

  Monster(this.name, this.health, this.damage, this.experience, this.level, this.image, int weight) : super(weight);
}