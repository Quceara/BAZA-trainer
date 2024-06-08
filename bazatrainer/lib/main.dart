import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Domain/supabaseCli.dart';
import 'Presentation/regView.dart';
import 'first_launch.dart';
import 'Presentation/profileView.dart';
import 'glavnaya.dart';
import 'Presentation/loginView.dart';
import 'Presentation/trainingView.dart';
import 'Presentation/diaryView.dart';
import 'Presentation/eatingView.dart';
import 'Presentation/systemView.dart';

void main() {
  runApp(BazaTrainerApp());
}

class BazaTrainerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // SupabaseCli();
    return MaterialApp(
      home: loginView(),
      initialRoute: "/profileView",
      routes: {
        // loginView.routeName: (context) => loginView(),
        TrainingPage.routeName: (context) => TrainingPage(),
        ProfilePage.routeName: (context) => ProfilePage(),
        DiaryPage.routeName: (context) => DiaryPage(),
        EatingPage.routeName: (context) => EatingPage(),
        SystemPage.routeName: (context) => SystemPage(),
      },
    );
  }
}
