import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'registration.dart';
import 'first_launch.dart';
import 'profile.dart';
import 'input.dart';
import 'glavnaya.dart';
import 'training.dart';
import 'diary.dart';
import 'eating.dart';
import 'system.dart';

void main() {
  runApp(BazaTrainerApp());
}

class BazaTrainerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
      initialRoute: ProfilePage.routeName,
      routes: {
        ProfilePage.routeName: (context) => ProfilePage(),
        TrainingPage.routeName: (context) => TrainingPage(),
        DiaryPage.routeName: (context) => DiaryPage(),
        EatingPage.routeName: (context) => EatingPage(),
        SystemPage.routeName: (context) => SystemPage(),
      },
    );
  }
}
