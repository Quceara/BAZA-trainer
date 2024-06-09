import 'package:bazatrainer/firstLaunch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Domain/sessionManager.dart';
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
import 'tracker.dart';
import 'InfoWidget.dart';
import 'first_launch.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //   url: 'https://fpttqwzlyoaqwyxjpxlj.supabase.co',
  //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZwdHRxd3pseW9hcXd5eGpweGxqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIzMzExMjAsImV4cCI6MjAyNzkwNzEyMH0.tgHK9DgkQv7x-zpZfYDHaa_78S60Bfh22GyXQiP0qfY',
  // );

  await SessionManager().restoreSession();
  runApp(BazaTrainerApp());
}

class BazaTrainerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // SupabaseCli();
    return MaterialApp(
      home: ProfilePage(),
      //home: SessionManager().isAuthenticated ? ProfilePage() : loginView(),
      initialRoute: "/",
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
