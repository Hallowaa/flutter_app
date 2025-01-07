import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/item/Item.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/views/FightView.dart';
import 'package:flutter_project/src/views/HomeView.dart';
import 'package:flutter_project/src/views/PassivesView.dart';
import 'package:flutter_project/src/views/SettingsView.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/src/model/item/ItemType.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  double _progressValue() {
    final provider = Provider.of<GameDataProvider>(context, listen: false);
    final currentLevel = provider.getLevel(provider.player.experience);
    final nextLevel = currentLevel + 1;

    if (nextLevel > 30) {
      return 1;
    }

    final currentExperience = provider.getExperience(currentLevel);
    final nextExperience = provider.getExperience(nextLevel);
    return (provider.player.experience - currentExperience) /
        (nextExperience - currentExperience);
  }

  void _equipItem(Item item) {
    GameDataProvider gp = Provider.of<GameDataProvider>(context, listen: false);

    if (item.equipped == true) {
      item.equipped = false;
      setState(() {});

      return;
    }

    switch (item.type) {
      case ItemType.weapon:
        {
          if (gp.player.weapon != null) {
            gp.player.weapon!.equipped = false;
          }
          break;
        }
      case ItemType.armor:
        {
          if (gp.player.armor != null) {
            gp.player.armor!.equipped = false;
          }
          break;
        }
      case ItemType.boots:
        {
          if (gp.player.boots != null) {
            gp.player.boots!.equipped = false;
          }
          break;
        }
      case ItemType.ring:
        {
          if (gp.player.ring != null) {
            gp.player.ring!.equipped = false;
          }
          break;
        }
      case ItemType.unset:
        {
          break;
        }
    }

    item.equipped = true;
    setState(() {});
  }

  void _displayItemInfo(BuildContext context, Item item) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Row(
                children: [
                  Padding(padding: const EdgeInsets.all(8), child: item.image),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(item.name,
                              style: Theme.of(context).textTheme.bodyMedium),
                          Row(
                            children: [
                              Expanded(
                                  child: Text("\"${item.description}\"",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Builder(builder: (context) {
                            List<Widget> children = [];
                            for (String name in item.getAllStatNames()) {
                              if (item.getTotalBoost(name) != 0) {
                                children.add(Text(
                                    '$name ${item.getTotalBoost(name)}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall));
                              }
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: children,
                            );
                          }),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => item.type != ItemType.unset
                                      ? {
                                          _equipItem(item),
                                          Navigator.pop(context),
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 44, 44, 44),
                                  ),
                                  child: Text(
                                    item.equipped ? 'Unequip' : 'Equip',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  )
                ],
              ),
              backgroundColor: Theme.of(context).primaryColorLight);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child:
              Consumer<GameDataProvider>(builder: (context, provider, child) {
            return AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Inventory',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: _progressValue(),
                      backgroundColor: Theme.of(context).primaryColorDark,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Level ${provider.getLevel(provider.player.experience)}',
                            style: Theme.of(context).textTheme.bodySmall),
                        Text('Dabloons ${provider.player.dabloons}',
                            style: Theme.of(context).textTheme.bodySmall),
                        Text('${provider.player.experience.floor()} EXP',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  )),
              backgroundColor: Theme.of(context).primaryColorLight,
            );
          })),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<GameDataProvider>(
          builder: (context, provider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (provider.player.weapon != null) {
                          _displayItemInfo(context, provider.player.weapon!);
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              provider.player.weapon == null
                                  ? const SizedBox(width: 60, height: 60)
                                  : provider.player.weapon!.image,
                              Text(
                                  provider.player.weapon == null
                                      ? 'Weapon'
                                      : provider.player.weapon!.name,
                                  style: Theme.of(context).textTheme.bodySmall)
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (provider.player.armor != null) {
                          _displayItemInfo(context, provider.player.armor!);
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              provider.player.armor == null
                                  ? const SizedBox(width: 60, height: 60)
                                  : provider.player.armor!.image,
                              Text(
                                  provider.player.armor == null
                                      ? 'Armor'
                                      : provider.player.armor!.name,
                                  style: Theme.of(context).textTheme.bodySmall)
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (provider.player.boots != null) {
                          _displayItemInfo(context, provider.player.boots!);
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              provider.player.boots == null
                                  ? const SizedBox(width: 60, height: 60)
                                  : provider.player.boots!.image,
                              Text(
                                  provider.player.boots == null
                                      ? 'Boots'
                                      : provider.player.boots!.name,
                                  style: Theme.of(context).textTheme.bodySmall)
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (provider.player.ring != null) {
                          _displayItemInfo(context, provider.player.ring!);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            provider.player.ring == null
                                ? const SizedBox(width: 60, height: 60)
                                : provider.player.ring!.image,
                            Text(
                                provider.player.ring == null
                                    ? 'Ring'
                                    : provider.player.ring!.name,
                                style: Theme.of(context).textTheme.bodySmall)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Builder(builder: (context) {
                  List<Widget> children = [];
                  for (var item
                      in Provider.of<GameDataProvider>(context, listen: false)
                          .player
                          .inventory) {
                    children.add(GestureDetector(
                      onTap: () => _displayItemInfo(context, item),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: item.equipped
                                  ? Theme.of(context).hintColor
                                  : Theme.of(context).primaryColorDark),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            item.image,
                            Text(item.name,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center),
                            Text(item.quantity.toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ));
                  }
                  return GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: children);
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle:
              WidgetStateProperty.all(Theme.of(context).textTheme.bodySmall),
        ),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.settings), label: 'Settings'),
            NavigationDestination(
                icon: Icon(Icons.arrow_upward), label: 'Passives'),
            NavigationDestination(
                icon: Icon(Icons.backpack), label: 'Inventory'),
            NavigationDestination(
                icon: Icon(Icons.electric_bolt), label: 'Fight'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          ],
          backgroundColor: Theme.of(context).primaryColorLight,
          selectedIndex: 2,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsView()));
                break;
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PassivesView()));
                break;
              case 2:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InventoryView()));
                break;
              case 3:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FightView()));
                break;

              case 4:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeView()));
                break;
            }
          },
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
    );
  }
}
