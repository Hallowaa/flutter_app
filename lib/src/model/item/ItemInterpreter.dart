import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/armor/ImpostorArmor.dart';
import 'package:flutter_project/src/model/item/boots/KeemstarBoots.dart';
import 'package:flutter_project/src/model/item/ring/DukeDennisRing.dart';
import 'package:flutter_project/src/model/item/weapon/GlizzySword.dart';

class ItemInterpreter {
  static List<Item> get items {
    return [GlizzySword(), DukeDennisRing(), ImpostorArmor(), KeemstarBoots()];
  }

  static Item getItem(int id) {
    return items[id];
  }

  static int getId(Item item) {
    List<Item> i = items;
    for (int j = 0; j < i.length; j++) {
      if (i[j].name == item.name) {
        return j;
      }
    }
    return 0;
  }
}
