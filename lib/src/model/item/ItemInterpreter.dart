import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/armor/ImpostorArmor.dart';
import 'package:flutter_project/src/model/item/boots/KeemstarBoots.dart';
import 'package:flutter_project/src/model/item/ring/DukeDennisRing.dart';
import 'package:flutter_project/src/model/item/weapon/GlizzySword.dart';

class ItemInterpreter {
  static final List<Item> items = [
    GlizzySword(),
    DukeDennisRing(),
    ImpostorArmor(),
    KeemstarBoots()
  ];

  static Item getItem(int id) {
    return items[id];
  }

  static int getId(Item item) {
    return items.indexOf(items.firstWhere((element) => element.name == item.name && element.description == item.description));
  }
}