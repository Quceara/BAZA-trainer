import 'package:flutter/material.dart';
import 'registration.dart';
import 'first_launch.dart';
import 'profile.dart';

void main() {
  runApp(BazaTrainerApp());
}

class BazaTrainerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: first_launch_build(),
    );
  }
}
