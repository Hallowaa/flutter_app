import 'package:flutter/material.dart';
import 'package:flutter_project/src/model/entity/Player.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/views/HomeView.dart';
import 'package:flutter_project/src/views/PassivesView.dart';
import 'package:flutter_project/src/views/SettingsView.dart';
import 'package:provider/provider.dart';

class FightView extends StatefulWidget {
  const FightView({super.key});

  @override
  State<FightView> createState() => _FightViewState();
}

class _FightViewState extends State<FightView> {
  double _progressValue() {
    final provider = Provider.of<GameDataProvider>(context, listen: false);
    final currentLevel = provider.getLevel(provider.player.experience);
    final nextLevel = currentLevel + 1;
    final currentExperience = provider.getExperience(currentLevel);
    final nextExperience = provider.getExperience(nextLevel);
    return (provider.player.experience - currentExperience) /
        (nextExperience - currentExperience);
  }

  @override
  Widget build(BuildContext context) {
    GameDataProvider gp = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(gp.player.name, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: _progressValue(),
                backgroundColor: Theme.of(context).primaryColorDark,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Level ${gp.getLevel(gp.player.experience)}',
                      style: Theme.of(context).textTheme.bodySmall),
                  Text('${gp.player.experience.floor()} EXP',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            )),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Health ${gp.fightManager != null ? gp.fightManager!.playerHealth : gp.player.health}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Damage ${gp.player.damage}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
              Builder(builder: (context) {
                List<Widget> result = [];
                List<Widget> rowChildren = [];

                ElevatedButton startEndBtn = ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorLight),
                  onPressed: () {
                    gp.fightManager == null ? gp.startFight() : gp.endFight();
                  },
                  child: Text(
                      gp.fightManager == null ? 'Start Fight' : 'End Fight',
                      style: Theme.of(context).textTheme.bodyMedium),
                );

                rowChildren.add(startEndBtn);

                if (gp.fightManager != null) {
                  Column monsterInfo = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          gp.fightManager!.monster.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Health ${gp.fightManager!.monster.health}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Damage ${gp.fightManager!.monster.minDamage} - ${gp.fightManager!.monster.maxDamage}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );

                  SizedBox listView = SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: gp.fightManager!.logs.length > 10
                          ? 10
                          : gp.fightManager!.logs.length,
                      itemBuilder: (context, index) {
                        int logIndex = gp.fightManager!.logs.length > 10
                            ? gp.fightManager!.logs.length - 10 + index
                            : index;
                        return Center(
                          child: Text(
                            gp.fightManager!.logs[logIndex],
                            style: TextStyle(
                                color: gp.fightManager!.entities[logIndex % 2] is Player
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 12
                            ),
                          ),
                        );
                      },
                    ),
                  );

                  result.addAll([
                    monsterInfo,
                    const SizedBox(height: 8),
                    gp.fightManager!.monster.image,
                    const SizedBox(height: 8),
                    listView
                  ]);

                  // add a button to do a player turn
                  ElevatedButton smackBtn = ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColorLight),
                    onPressed: () {
                      gp.fightManager!.doTurn();
                      setState(() {});
                    },
                    child: Text('Smack',
                        style: Theme.of(context).textTheme.bodyMedium),
                  );

                  rowChildren.addAll([const SizedBox(width: 20), smackBtn]);
                }

                Row row = Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: rowChildren);

                result.add(row);

                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: result);
              })
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
                icon: Icon(Icons.auto_awesome_outlined), label: 'Fight'),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FightView()));
                break;
              case 3:
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
