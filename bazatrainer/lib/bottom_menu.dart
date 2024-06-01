import 'package:bazatrainer/profile.dart';
import 'package:flutter/material.dart';
import 'glavnaya.dart';
import 'training.dart';
import 'diary.dart';
import 'eating.dart';
import 'system.dart';

class BottomMenu extends StatefulWidget {
  final int currentIndex;

  const BottomMenu({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  void _onItemTapped(int index) {
    if (index != widget.currentIndex) {
      String? route;
      switch (index) {
        case 0:
          route = ProfilePage.routeName;
          break;
        case 1:
          route = TrainingPage.routeName;
          break;
        case 2:
          route = DiaryPage.routeName;
          break;
        case 3:
          route = EatingPage.routeName;
          break;
        case 4:
          route = SystemPage.routeName;
          break;
      }
      if (route != null) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    }
  }

  Widget _buildIcon(IconData iconData, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Icon(
        iconData,
        color: widget.currentIndex == index ? Colors.white : Color.fromRGBO(159, 159, 159, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(14, 14, 14, 1),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(Icons.person, 0),
          _buildIcon(Icons.fitness_center_outlined, 1),
          _buildIcon(Icons.menu_book, 2),
          _buildIcon(Icons.restaurant_menu_outlined, 3),
          _buildIcon(Icons.power_settings_new, 4),
        ],
      ),
    );
  }
}
