import 'package:bazatrainer/menu.dart';
import 'package:flutter/material.dart';
import 'bottom_menu.dart';

class SystemPage extends StatelessWidget {
  static const String routeName = '/systemView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: Center(
          child: Text(
            'Система',
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/pictures/Geraklit.png', fit: BoxFit.cover),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: BottomMenu(
                currentIndex: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}