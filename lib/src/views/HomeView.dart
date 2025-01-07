import 'package:flutter/material.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/providers/movement/ESenseMovementProvider.dart';
import 'package:flutter_project/src/views/FightView.dart';
import 'package:flutter_project/src/views/InventoryView.dart';
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

    if (nextLevel > 30) {
      return 1;
    }

    final currentExperience = provider.getExperience(currentLevel);
    final nextExperience = provider.getExperience(nextLevel);
    return (provider.player.experience - currentExperience) /
        (nextExperience - currentExperience);
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
      body: Center(
        child: Consumer<GameDataProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Speed',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                              (Provider.of<GameDataProvider>(context, listen: true)
                                      .totalSpeed)
                                  .toStringAsFixed(2),
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Speed boost',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                              '${(((Provider.of<GameDataProvider>(context, listen: true)
                                  .totalSpeedBoost - 1) * 100)
                                  .toStringAsFixed(0))}%',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('EXP gain',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                              (Provider.of<GameDataProvider>(context,
                                          listen: true)
                                      .expGain)
                                  .toStringAsFixed(2),
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('EXP boost',
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(
                              '${((Provider.of<GameDataProvider>(context, listen: true).totalExpBoost - 1) * 100).toStringAsFixed(0)}%',
                            )
                          ])
                    ],
                  )),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
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
                        Text('Max health',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('${provider.player.health}',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Damage',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('${provider.player.damage} - ${provider.player.damage + provider.player.extraDamage}',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 41, 41, 41),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text('+1 Damage',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 49, 49, 49),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text('+10 Health',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                              const SizedBox(width: 6),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 49, 49, 49),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                              '+${provider.player.strength} Damage +${provider.player.strength * 10} Health',
                              style: Theme.of(context).textTheme.bodySmall),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
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
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 41, 41, 41),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text('+1% Speed',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 49, 49, 49),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text('+${provider.player.dexterity}% Speed',
                              style: Theme.of(context).textTheme.bodySmall),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Intelligence',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text('${provider.player.intelligence}',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 41, 41, 41),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text('+1% EXP',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 49, 49, 49),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text('+${provider.player.intelligence}% EXP',
                              style: Theme.of(context).textTheme.bodySmall),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
            NavigationDestination(
                icon: Icon(Icons.backpack), label: 'Inventory'),
            NavigationDestination(
                icon: Icon(Icons.electric_bolt), label: 'Fight'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          ],
          backgroundColor: Theme.of(context).primaryColorLight,
          selectedIndex: 4,
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
