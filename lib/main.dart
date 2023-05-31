import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/pages/inscription.page.dart';
import '/pages/authentification.page.dart';
import '/pages/home.page.dart';

void main() {
  void logSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> allPrefs = prefs.getKeys().fold({}, (prev, key) {
      prev[key] = prefs.get(key);
      return prev;
    });
    print('Shared Preferences:');
    print(allPrefs);
  }
  logSharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? connecte;

  @override
  void initState() {
    super.initState();
    checkConnecteStatus();
  }

  void checkConnecteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      connecte = prefs.getBool('connecte');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connexion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: connecte == true ? '/' : '/inscription',
      routes: {
        '/': (context) => HomePage(),
        '/inscription': (context) => InscriptionPage(),
        '/authentification': (context) => AuthentificationPage(),
      },
    );
  }
}
