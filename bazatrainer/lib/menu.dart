import 'package:flutter/material.dart';
import 'images_receiving.dart';
import 'firstLaunch.dart';

class CustomNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Right Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          NotificationWidget(),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 27, 27, 27), // Фоновый цвет
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(27, 27, 27, 1),
              ),
              child: Text(
                'Меню',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ), // Иконка "Выйти"
              title: Text(
                'Выйти',
                style: TextStyle(
                  color: Colors.white, // Цвет текста "Выйти"
                ),
              ),
              onTap: () {
                // Переход на страницу FirstLaunch()
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstLaunch()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'photoUrl': 'https://sun9-18.userapi.com/impg/PmUbRp_4K_dCdHcIxSR378HEcx7vlv0yCYn9mg/CbDWmeSOl48.jpg?size=1098x830&quality=96&sign=1c2fa5d6c3ddb03a16575b41d9ddead7&type=album',
      'username': 'John Doe',
      'notificationDate': 'May 24, 2024',
    },
    {
      'photoUrl': 'https://sun9-18.userapi.com/impg/PmUbRp_4K_dCdHcIxSR378HEcx7vlv0yCYn9mg/CbDWmeSOl48.jpg?size=1098x830&quality=96&sign=1c2fa5d6c3ddb03a16575b41d9ddead7&type=album',
      'username': 'John Doe',
      'notificationDate': 'May 24, 2024',
    },
    {
      'photoUrl': 'https://sun9-18.userapi.com/impg/PmUbRp_4K_dCdHcIxSR378HEcx7vlv0yCYn9mg/CbDWmeSOl48.jpg?size=1098x830&quality=96&sign=1c2fa5d6c3ddb03a16575b41d9ddead7&type=album',
      'username': 'John Doe',
      'notificationDate': 'May 24, 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((notification) {
        return _buildNotificationWidget(
          notification['photoUrl'] ?? '',
          notification['username'] ?? '',
          notification['notificationDate'] ?? '',
        );
      }).toList(),
    );
  }

  Widget _buildNotificationWidget(String photoUrl, String username, String notificationDate) {

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(photoUrl),
                radius: 25,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    notificationDate,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

