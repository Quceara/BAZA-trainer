import 'package:flutter/material.dart';

class TrainingProgramWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Активная программа тренировок'),
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Действие при нажатии на кнопку
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(14, 14, 14, 1),
          ),
          child: Text(
            'Активная программа тренировок',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
