import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/providers/movement/ESenseMovementProvider.dart';
import 'package:flutter_project/src/views/PassivesView.dart';
import 'package:flutter_project/src/views/SettingsView.dart';
import 'package:provider/provider.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _loadPlayer() async {
    Provider.of<GameDataProvider>(context, listen: false).loadPlayer('default');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(100),
      child: FutureBuilder(future: _loadPlayer(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<GameDataProvider>(builder: (context, provider, child) {
            return AppBar(
              automaticallyImplyLeading: false,
              title: Text(provider.player.name, style: Theme.of(context).textTheme.titleLarge),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Level ${provider.getLevel(provider.player.experience)}', style: Theme.of(context).textTheme.bodySmall),
                      Text('${provider.player.experience} EXP', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                )
              ),
              backgroundColor: Theme.of(context).primaryColorLight,
            );
          });
        } else {
          return AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Loading...', style: TextStyle(color: Colors.white)),
            backgroundColor: Theme.of(context).primaryColorLight,
          );
        }
      })),
      body: Center(
        child: Container( 
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ESenseMovementProvider>(
                builder: (content, provider, child) {
                  return Text('Speed: ${provider.deviceSpeedMagnitude.toStringAsFixed(2)}',style: Theme.of(context).textTheme.bodyMedium);
                }
              ),
              const SizedBox(height: 20),
              Consumer<ESenseMovementProvider>(
                builder: (content, provider, child) {
                  return ElevatedButton(
                    onPressed: () {
                      provider.alternativeConnect();
                    },
                    child: const Text('Use device sensor'),
                  );
                }
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(Theme.of(context).textTheme.bodySmall),
        ),
        child: NavigationBar(destinations: const [
            NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
            NavigationDestination(icon: Icon(Icons.arrow_upward), label: 'Passives'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          ],
          backgroundColor: Theme.of(context).primaryColorLight,
          selectedIndex: 2,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView()));
                break;
              case 1:
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PassivesView()));
                break;
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
                break;
              }
          },
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
    );
  }
}