import 'package:flutter/material.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/providers/movement/ESenseMovementProvider.dart';
import 'package:flutter_project/src/views/FightView.dart';
import 'package:flutter_project/src/views/PassivesView.dart';
import 'package:flutter_project/src/views/SettingsView.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  double _progressValue() {
    final provider = Provider.of<GameDataProvider>(context, listen: false);
    final currentLevel = provider.getLevel(provider.player.experience);
    final nextLevel = currentLevel + 1;
    final currentExperience = provider.getExperience(currentLevel);
    final nextExperience = provider.getExperience(nextLevel);
    return (provider.player.experience - currentExperience) / (nextExperience - currentExperience);
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
                  Text(provider.player.name,
                      style: Theme.of(context).textTheme.titleLarge),
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Level ${provider.getLevel(provider.player.experience)}',
                            style: Theme.of(context).textTheme.bodySmall),
                        Text('${provider.player.experience.floor()} EXP',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  )),
              backgroundColor: Theme.of(context).primaryColorLight,
            );
          })),
      body: Center(
        child: Consumer<GameDataProvider>(builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Speed',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(
                                (Provider.of<ESenseMovementProvider>(context)
                                    .deviceSpeedMagnitude * provider
                                        .speedBoostValues[provider.player.speedBoost])
                                    .toStringAsFixed(2),
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Strength',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('${provider.player.strength}',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Dexterity',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('${provider.player.dexterity}',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Intelligence',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text('${provider.player.intelligence}',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Image(
                  image: AssetImage('assets/images/player.png'),
                  height: 300,
                )
              ],
            ),
          );
        }),
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
            NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), label: 'Fight'),
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
