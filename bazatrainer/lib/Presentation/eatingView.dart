import 'package:bazatrainer/menu.dart';
import 'package:flutter/material.dart';
import 'bottom_menu.dart';
import 'dart:async';

class EatingPage extends StatefulWidget {
  static const String routeName = '/eatingView';

  @override
  _EatingPageState createState() => _EatingPageState();
}

class _EatingPageState extends State<EatingPage> {
  int _selectedIndex = 0;
  late Future<List<Map<String, dynamic>>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
  }

  void _selectMenu(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromRGBO(14, 14, 14, 1),
        title: Center(
          child: Text(
            'Питание',
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
      backgroundColor: Color.fromRGBO(27, 27, 27, 1),
      body: Column(
        children: [
          // Первая часть
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuItem(0, "Все"),
                _buildMenuItem(1, "Мои"),
                _buildMenuItem(2, "Готовые"),
              ],
            ),
          ),
          // Вторая часть
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Данных нет...'));
                }

                final filteredData = _filterData(snapshot.data!);
                return ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final item = filteredData[index];
                    return _buildItem(context, index, item);
                  },
                );
              },
            ),
          ),
          // Третья часть
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
            decoration: BoxDecoration(
              color: Color.fromRGBO(27, 27, 27, 1),
            ),
            child: BottomMenu(
              currentIndex: 3,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<List<Map<String, dynamic>>> _loadData() async {
    return [
      {
        'title': 'Пример пункта 1',
        'trainer': 'Тренер 1',
        'date': '01-01-2023',
        'image_url': 'https://via.placeholder.com/1000x500',
        'category': 'Мои',
        'exercises': [
          {
            'title': 'Упражнение 1',
            'description': 'Описание упражнения 1',
            'steps': [
              {'description': 'Шаг 1'},
              {'description': 'Шаг 2'},
            ],
          },
        ],
      },
      {
        'title': 'Пример пункта 2',
        'trainer': 'Тренер 2',
        'date': '02-01-2023',
        'image_url': 'https://via.placeholder.com/1000x500',
        'category': 'Готовые',
        'exercises': [
          {
            'title': 'Упражнение 2',
            'description': 'Описание упражнения 2',
            'steps': [
              {'description': 'Шаг 1'},
              {'description': 'Шаг 2'},
            ],
          },
        ],
      },
    ];
  }

  List<Map<String, dynamic>> _filterData(List<Map<String, dynamic>> data) {
    if (_selectedIndex == 1) {
      return data.where((item) => item['category'] == 'Мои').toList();
    } else if (_selectedIndex == 2) {
      return data.where((item) => item['category'] == 'Готовые').toList();
    } else {
      return data;
    }
  }

  Widget _buildMenuItem(int index, String title) {
    return GestureDetector(
      onTap: () {
        _selectMenu(index);
      },
      child: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.white : Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 125,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(item['image_url'] ?? "https://via.placeholder.com/1000x500"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        item['trainer'] ?? 'Trainer',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        item['date'] ?? 'Date',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
