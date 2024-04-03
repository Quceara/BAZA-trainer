import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

class ProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: UserHomePage(),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Имя пользователя1'),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromRGBO(27, 27, 27, 1), // Прозрачный фон AppBar
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      backgroundColor: Color.fromRGBO(27, 27, 27, 1),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(27, 27, 27, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Имя пользователя123',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Профиль'),
                onTap: () {
                  // Действия при выборе элемента меню
                },
              ),
              ListTile(
                title: Text('Лента'),
                onTap: () {
                  // Действия при выборе элемента меню
                },
              ),
              ListTile(
                title: Text('Чат'),
                onTap: () {
                  // Действия при выборе элемента меню
                },
              ),
              ListTile(
                title: Text('Настройки'),
                onTap: () {
                  // Действия при выборе элемента меню
                },
              ),
              ListTile(
                title: Text('Инструкция'),
                onTap: () {
                  // Действия при выборе элемента меню
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            SizedBox(height: 20),
            Text(
              'Имя пользователя',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'email@example.com',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку "Редактировать профиль"
              },
              child: Text('Редактировать'),
            ),
          ],
        ),
      ),
      color: Color.fromRGBO(27, 27, 27, 1),
    );
  }
}
