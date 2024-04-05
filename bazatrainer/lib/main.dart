import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'registration.dart';
import 'first_launch.dart';
import 'profile.dart';
import 'Presentation/loginView.dart';
import 'Domain/supabaseCli.dart';

void main() {
  SupabaseCli();
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
      home: FirstLaunchBuild(),
    );
  }
}
