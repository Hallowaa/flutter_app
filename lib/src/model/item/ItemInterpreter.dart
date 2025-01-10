import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/armor/ArmorGold.dart';
import 'package:flutter_project/src/model/item/armor/ArmorIron.dart';
import 'package:flutter_project/src/model/item/boots/BootsLeather.dart';
import 'package:flutter_project/src/model/item/boots/BootsGold.dart';
import 'package:flutter_project/src/model/item/ring/RingMagic.dart';
import 'package:flutter_project/src/model/item/ring/RingGold.dart';
import 'package:flutter_project/src/model/item/weapon/SwordDiamond.dart';
import 'package:flutter_project/src/model/item/weapon/SwordNeutral.dart';
import 'package:flutter_project/src/model/item/weapon/SwordWood.dart';
import 'package:flutter_project/src/model/item/weapon/SwordVoid.dart';

class ItemInterpreter {
  static List<Item> get items {
    return [
      // armor
      ArmorGold(),
      ArmorIron(),

      // boots
      BootsLeather(),
      BootsGold(),

      // rings
      RingMagic(),
      RingGold(),

      // weapons
      SwordWood(),
      SwordDiamond(),
      SwordNeutral(),
      SwordVoid()
    ];
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
