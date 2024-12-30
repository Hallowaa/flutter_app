import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/armor/ArmorImpostor.dart';
import 'package:flutter_project/src/model/item/boots/BootsKeemstar.dart';
import 'package:flutter_project/src/model/item/ring/RingDukeDennis.dart';
import 'package:flutter_project/src/model/item/weapon/SwordGlizzy.dart';

class ItemInterpreter {
  static List<Item> get items {
    return [SwordGlizzy(), RingDukeDennis(), ArmorImpostor(), BootsKeemstar()];
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
