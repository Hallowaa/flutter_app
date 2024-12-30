import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/Player.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/views/HomeView.dart';
import 'package:flutter_project/src/views/InventoryView.dart';
import 'package:flutter_project/src/views/PassivesView.dart';
import 'package:flutter_project/src/views/SettingsView.dart';
import 'package:provider/provider.dart';

class FightView extends StatefulWidget {
  const FightView({super.key});

  @override
  State<FightView> createState() => _FightViewState();
}

class _FightViewState extends State<FightView> {
  bool _btnDisabled = false;

  double _progressValue() {
    final provider = Provider.of<GameDataProvider>(context, listen: false);
    final currentLevel = provider.getLevel(provider.player.experience);
    final nextLevel = currentLevel + 1;
    final currentExperience = provider.getExperience(currentLevel);
    final nextExperience = provider.getExperience(nextLevel);
    return (provider.player.experience - currentExperience) /
        (nextExperience - currentExperience);
  }

  void _doTurn(BuildContext context) {
    final provider = Provider.of<GameDataProvider>(context, listen: false);
    setState(() {
      _btnDisabled = true;
    });
    provider.fightManager!.doTurn(context);
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _btnDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    GameDataProvider gp = Provider.of(context);

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
                  Text('Fight',
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
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Image.asset('assets/images/playerFace.png',
                            height: 60, width: 60),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 7),
                            LinearProgressIndicator(
                              value: gp.fightManager == null
                                  ? 1
                                  : gp.fightManager!.playerHealth /
                                      gp.player.health,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      gp.player.name,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Damage ${gp.player.damage} - ${gp.player.damage + gp.player.extraDamage}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  )
                                ]),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Health ${gp.fightManager == null ? gp.player.health : gp.fightManager!.playerHealth}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                )
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Builder(builder: (context) {
                    if (gp.fightManager == null) {
                      return const SizedBox();
                    }

                    return SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          gp.fightManager!.monster.image,
                          const SizedBox(width: 10),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 7),
                              LinearProgressIndicator(
                                value: gp.fightManager!.monster.health /
                                    gp.fightManager!.monsterMaxHealth,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.red),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        gp.fightManager!.monster.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Damage ${gp.fightManager!.monster.minDamage} - ${gp.fightManager!.monster.maxDamage}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    )
                                  ]),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'Health ${gp.fightManager!.monster.health}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            Builder(builder: (context) {
              List<Widget> res = [];
              List<Widget> buttons = [];
              ElevatedButton startOrEndFightButton = ElevatedButton(
                onPressed: () {
                  if (gp.fightManager == null) {
                    gp.startFight();
                  } else {
                    gp.endFight(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: Text(
                  gp.fightManager == null ? 'Start Fight' : 'End Fight',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );

              buttons.add(startOrEndFightButton);

              if (gp.fightManager != null) {
                ElevatedButton attackButton = ElevatedButton(
                  onPressed: () =>
                      _btnDisabled == true ? null : _doTurn(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _btnDisabled == true
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).primaryColorLight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: Text(
                    'Attack',
                    style: _btnDisabled == true
                        ? TextStyle(
                            color: const Color.fromARGB(255, 99, 99, 99),
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          )
                        : Theme.of(context).textTheme.bodyMedium,
                  ),
                );

                buttons.add(const SizedBox(height: 20));
                buttons.add(attackButton);

                SizedBox combatLogs = SizedBox(
                  height: 350,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: gp.fightManager!.logs.length,
                      itemBuilder: (context, index) {
                        bool isPlayerAttack = index % 2 == 0;
                        return Align(
                          alignment: isPlayerAttack
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              gp.fightManager!.logs[index],
                              style: TextStyle(
                                  color: isPlayerAttack ? Colors.green : Colors.red,
                                  fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );

                res.add(combatLogs);
                res.add(const SizedBox(height: 20));
              }

              return Column(
                children: [
                  ...res,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: buttons,
                  )
                ],
              );
            })
          ],
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
          selectedIndex: 3,
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
