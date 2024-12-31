import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/model/item/armor/ArmorAmericaCap.dart';
import 'package:flutter_project/src/model/item/armor/ArmorImpostor.dart';
import 'package:flutter_project/src/model/item/boots/BootsHardsocks.dart';
import 'package:flutter_project/src/model/item/boots/BootsKeemstar.dart';
import 'package:flutter_project/src/model/item/ring/RingDukeDennis.dart';
import 'package:flutter_project/src/model/item/ring/RingEpstein.dart';
import 'package:flutter_project/src/model/item/weapon/SwordDiamond.dart';
import 'package:flutter_project/src/model/item/weapon/SwordDiddy.dart';
import 'package:flutter_project/src/model/item/weapon/SwordGlizzy.dart';
import 'package:flutter_project/src/model/item/weapon/WeaponMoldyCheese.dart';

class ItemInterpreter {
  static List<Item> get items {
    return [
      SwordGlizzy(),
      RingDukeDennis(),
      ArmorImpostor(),
      BootsKeemstar(),
      ArmorAmericaCap(),
      BootsHardsocks(),
      RingEpstein(),
      SwordDiamond(),
      SwordDiddy(),
      WeaponMoldyCheese()
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
