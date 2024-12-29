import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/Weighted.dart';

class Monster extends Weighted {
  String name = '';
  int health = 0;
  final int _minDamage;
  final int _maxDamage;
  int experience = 0;
  int level = 0;
  Image image = Image.asset('assets/images/perandus.png', width: 60, height: 60);

  int get minDamage => _minDamage;
  int get maxDamage => _maxDamage;
  int get damage {
    // random damage between min and max
    return Random().nextInt(_maxDamage - _minDamage) + _minDamage;
  }

  Monster(this.name, this.health, this._minDamage, this._maxDamage, this.experience, this.level, this.image, double weight) : super(weight);

  void takeDamage(int damage) {
    health -= damage;
  }
}