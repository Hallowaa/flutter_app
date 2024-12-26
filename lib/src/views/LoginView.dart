import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/src/util/StorageManager.dart';
import 'package:flutter_project/src/views/HomeView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _Loginview();
}

class _Loginview extends State<LoginView> {
  String _username = '';
  String _password = '';
  String _error = '';
  final StorageManager _storageManager = StorageManager();

  void _login() async {
    try {
      // try to find a file with the username
      File file = await _storageManager.loadFile(_username);

      // if the file is found, check the password
      if (file.existsSync()) {
        dynamic jsonFile = await _storageManager.readFileAsJson(_username);

        if (jsonFile['password'] == _password) {
          if (context.mounted) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
          }
        }
      }
    } catch (e) {
      _error = 'Invalid username or password';
    }
  }

  void _handleUsernameChange(String value) {
    setState(() {
      _username = value;
    });
  }

  void _handlePasswordChange(String value) {
    setState(() {
      _password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Container(
        padding: const EdgeInsets.all(24),
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: (value) => _handleUsernameChange(value),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: (value) => _handlePasswordChange(value),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child:  ElevatedButton(
                  onPressed: () => _login(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 20),
                  ),
                  child: Text('Login', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              Text(_error, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
    );
  }
}
