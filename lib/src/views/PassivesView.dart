import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/views/HomeView.dart';
import 'package:flutter_project/src/views/SettingsView.dart';
import 'package:provider/provider.dart';

class PassivesView extends StatefulWidget {
  const PassivesView({super.key});

  @override
  State<PassivesView> createState() => _PassivesViewState();
}

class _PassivesViewState extends State<PassivesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child:
              Consumer<GameDataProvider>(builder: (context, provider, child) {
            return AppBar(
              automaticallyImplyLeading: false,
              title: Text(provider.player.name,
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
                            'Level ${provider.getLevel(provider.player.experience)}',
                            style: Theme.of(context).textTheme.bodySmall),
                        Text('${provider.player.experience} EXP',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  )),
              backgroundColor: Theme.of(context).primaryColorLight,
            );
          })),
      body: const Padding(padding: EdgeInsets.all(16), child: null),
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
