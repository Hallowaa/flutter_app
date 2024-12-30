import 'package:flutter/material.dart';
import 'package:flutter_project/src/providers/movement/ESenseMovementProvider.dart';
import 'package:flutter_project/src/views/FightView.dart';
import 'package:flutter_project/src/views/HomeView.dart';
import 'package:flutter_project/src/views/InventoryView.dart';
import 'package:flutter_project/src/views/PassivesView.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Use device sensors',
                    style: Theme.of(context).textTheme.bodyMedium),
                Switch(
                  value: Provider.of<ESenseMovementProvider>(context,
                          listen: false)
                      .useDeviceSensors,
                  onChanged: (value) {
                    setState(() {
                      Provider.of<ESenseMovementProvider>(context,
                              listen: false)
                          .useDeviceSensors = value;
                    });
                  },
                ),
              ],
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
                icon: Icon(Icons.backpack), label: 'Inventory'),
            NavigationDestination(
                icon: Icon(Icons.electric_bolt), label: 'Fight'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          ],
          backgroundColor: Theme.of(context).primaryColorLight,
          selectedIndex: 0,
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
