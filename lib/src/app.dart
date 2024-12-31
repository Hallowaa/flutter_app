import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project/src/providers/game/GameDataProvider.dart';
import 'package:flutter_project/src/providers/movement/ESenseMovementProvider.dart';
import 'package:flutter_project/src/views/HomeView.dart';
import 'package:provider/provider.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ESenseMovementProvider eSenseMovementProvider = ESenseMovementProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => eSenseMovementProvider),
      ChangeNotifierProvider(create: (context) => GameDataProvider(eSenseMovementProvider)),
    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorDark: Colors.black54,
        primaryColorLight: const Color.fromARGB(255, 34, 34, 34),
        iconTheme: const IconThemeData(color: Colors.white),
        hintColor: const Color.fromARGB(255, 154, 207, 156),
        disabledColor: Colors.grey,
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 34),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 18),
          bodySmall: TextStyle(color: Color.fromARGB(155, 255, 255, 255), fontSize: 12),
          labelSmall: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
          displaySmall: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeView(),
      )
    );
  }
}
