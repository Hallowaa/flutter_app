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
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                            : gp.fightManager!.playerHealth / gp.player.health,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                gp.player.name,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Damage: ${gp.getDamage()} - ${gp.getDamage() + gp.player.extraDamage}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            )
                          ])
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
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
