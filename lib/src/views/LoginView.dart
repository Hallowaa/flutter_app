import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _Loginview();
}

class _Loginview extends State<LoginView> {
  String _username = '';
  String _password = '';

  void _login() {
    // temporary login for admin
    if (_username == 'admin' && _password == 'admin') {
      
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
              )
            ],
          ),
        ),
    );
  }
}
