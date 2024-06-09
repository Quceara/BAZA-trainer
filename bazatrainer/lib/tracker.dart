import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(BoxingTimerApp());

class BoxingTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _intervalValue = 30; // Инициализация _intervalValue
  int _currentTime = 30; // Текущее время таймера
  late Timer _timer; // Таймер

  void _setInterval(int? value) {
    if (value != null) {
      setState(() {
        _intervalValue = value;
        _currentTime = value; // Сбросить текущее время при изменении интервала
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime--;
        } else {
          _timer.cancel(); // Остановить таймер при достижении 0
        }
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel(); // Остановить таймер при уничтожении виджета
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Интервал: $_intervalValue сек',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Таймер: $_currentTime сек',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _startTimer,
                  child: Text('Старт'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text('Стоп'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Выберите интервал:'),
                SizedBox(width: 10.0),
                DropdownButton<int>(
                  value: _intervalValue,
                  onChanged: _setInterval,
                  items: [15, 30, 45, 60]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value сек'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
