import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/src/providers/movement/ESenseMovementProvider.dart';
import 'package:flutter_project/src/providers/movement/MovementProvider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:provider/provider.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container( 
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ESenseMovementProvider>(
                builder: (content, provider, child) {
                  return Text('Speed: ${sqrt(pow(provider.speed[0], 2) + pow(provider.speed[1], 2) + pow(provider.speed[2], 2)).toStringAsFixed(2)}',style: Theme.of(context).textTheme.bodyMedium);
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
      backgroundColor: Theme.of(context).primaryColorDark,
    );
  }
}