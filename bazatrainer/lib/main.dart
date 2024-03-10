import 'package:flutter/material.dart';
import 'registration.dart';
import 'profile.dart'; // Импортируем файл с виджетом профиля

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
      home: RegistrationPage(), // Устанавливаем ProfilePage как главную страницу
    );
  }
}
