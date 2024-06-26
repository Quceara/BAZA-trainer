import 'package:bazatrainer/menu.dart';
import 'package:flutter/material.dart';
import 'bottom_menu.dart';
import '../note.dart';

class TrainingEndView extends StatelessWidget {
  static const String routeName = '/trainingEndView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: Center(
          child: Text(
            'Тренировка',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.message_outlined, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      endDrawer: CustomNotification(),
      body: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Color.fromRGBO(27, 27, 27, 1),
              body: Text('Сюда'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
            decoration: BoxDecoration(
              color: Color.fromRGBO(27, 27, 27, 1),
            ),
            child: BottomMenu(
              currentIndex: 2,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
