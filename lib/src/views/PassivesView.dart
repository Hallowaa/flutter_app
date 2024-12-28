import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/views/FightView.dart';
import 'package:flutter_project/src/views/HomeView.dart';
import 'package:flutter_project/src/views/SettingsView.dart';
import 'package:provider/provider.dart';

class PassivesView extends StatefulWidget {
  const PassivesView({super.key});

  @override
  State<PassivesView> createState() => _PassivesViewState();
}

class _PassivesViewState extends State<PassivesView> {
  bool _canAfford(int cost) {
    return Provider.of<GameDataProvider>(context, listen: false)
            .remainingPassivePoints() >=
        cost;
  }

  bool _canUpgradeSpeed() {
    GameDataProvider provider =
        Provider.of<GameDataProvider>(context, listen: false);
    return provider.player.speedBoost < provider.speedBoostValues.length - 1;
  }

  bool _canUpgradeFrequency() {
    GameDataProvider provider =
        Provider.of<GameDataProvider>(context, listen: false);
    return provider.player.speedFrequency < provider.speedFrequencyValues.length - 1;
  }

  bool _canUpgradeExp() {
    GameDataProvider provider =
        Provider.of<GameDataProvider>(context, listen: false);
    return provider.player.expBoost < provider.expBoostValues.length - 1;
  }

  String _upgradeSpeedText() {
    GameDataProvider provider =
        Provider.of<GameDataProvider>(context, listen: false);
    String result =
        '${provider.speedBoostValues[provider.player.speedBoost]}x ';
    if (_canUpgradeSpeed()) {
      result +=
          '-> ${provider.speedBoostValues[provider.player.speedBoost + 1]}x';
    }

    return result;
  }

  String _upgradeFrequencyText() {
    GameDataProvider provider =
        Provider.of<GameDataProvider>(context, listen: false);
    String result =
        '${provider.speedFrequencyValues[provider.player.speedFrequency]} sec ';
    if (_canUpgradeFrequency()) {
      result +=
          '-> ${provider.speedFrequencyValues[provider.player.speedFrequency + 1]} sec';
    }

    return result;
  }

  String _upgradeExpText() {
    GameDataProvider provider =
        Provider.of<GameDataProvider>(context, listen: false);
    String result = '${provider.expBoostValues[provider.player.expBoost]}x ';
    if (_canUpgradeExp()) {
      result += '-> ${provider.expBoostValues[provider.player.expBoost + 1]}x';
    }

    return result;
  }

  void _upgradeSpeed() {
    if (_canUpgradeSpeed() && _canAfford(1)) {
      Provider.of<GameDataProvider>(context, listen: false).upgradeSpeed();
    }
  }

  void _upgradeFrequency() {
    if (_canUpgradeFrequency() && _canAfford(1)) {
      Provider.of<GameDataProvider>(context, listen: false).upgradeFrequency();
    }
  }

  void _upgradeExp() {
    if (_canUpgradeExp() && _canAfford(1)) {
      Provider.of<GameDataProvider>(context, listen: false).upgradeExp();
    }
  }

  @override
  Widget build(BuildContext context) {
    GameDataProvider provider =
        Provider.of<GameDataProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child:
              Consumer<GameDataProvider>(builder: (context, provider, child) {
            return AppBar(
              automaticallyImplyLeading: false,
              title: Text('Passives',
                  style: Theme.of(context).textTheme.titleLarge),
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
                            'Remaining passive points ${provider.remainingPassivePoints()}',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  )),
              backgroundColor: Theme.of(context).primaryColorLight,
            );
          })),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 16,
            childAspectRatio: (1 / .4),
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 48),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/tabi.png'),
                          height: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Increased speed',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Level ${Provider.of<GameDataProvider>(context).player.speedBoost}',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            ElevatedButton(
                              onPressed:
                                  _canUpgradeSpeed() && _canAfford(1) ? _upgradeSpeed : null,
                              style: ElevatedButton.styleFrom(
                                  disabledBackgroundColor:
                                      Theme.of(context).primaryColorDark,
                                  disabledForegroundColor: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color,
                                  fixedSize: const Size(100, 40)),
                              child: Text(
                                  provider.speedBoostValues.length - 1 <=
                                          provider.player.speedBoost
                                      ? 'MAX'
                                      : 'Cost 1'),
                            ),
                            Text(
                              _upgradeSpeedText(),
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ]),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/stopwatch.png'),
                        height: 100,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Increased frequency',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Level ${Provider.of<GameDataProvider>(context).player.speedFrequency}',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            onPressed: _canUpgradeFrequency() && _canAfford(1)
                                ? _upgradeFrequency
                                : null,
                            style: ElevatedButton.styleFrom(
                                disabledBackgroundColor:
                                    Theme.of(context).primaryColorDark,
                                disabledForegroundColor: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color,
                                fixedSize: const Size(100, 40)),
                            child: Text(
                                provider.speedFrequencyValues.length - 1 <=
                                        provider.player.speedFrequency
                                    ? 'MAX'
                                    : 'Cost 1'),
                          ),
                          Text(
                            _upgradeFrequencyText(),
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/perandus.png'),
                        height: 100,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Increased experience',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Level ${Provider.of<GameDataProvider>(context).player.expBoost}',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                            onPressed: _canUpgradeExp() && _canAfford(1) ? _upgradeExp : null,
                            style: ElevatedButton.styleFrom(
                                disabledBackgroundColor:
                                    Theme.of(context).primaryColorDark,
                                disabledForegroundColor: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color,
                                fixedSize: const Size(100, 40)),
                            child: Text(provider.expBoostValues.length - 1 <=
                                    provider.player.expBoost
                                ? 'MAX'
                                : 'Cost 1'),
                          ),
                          Text(
                            _upgradeExpText(),
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
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
          selectedIndex: 1,
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
