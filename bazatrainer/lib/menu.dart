import 'package:flutter/material.dart';
import 'images_receiving.dart';
import 'firstLaunch.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 27, 27, 27),
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
              ),
              title: Text(
                'Выйти',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FirstLaunch()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(27, 27, 27, 1),
            ),
            child: Text(
              'Уведомления',
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

class NotificationWidget extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'photoUrl': 'https://sun9-80.userapi.com/impg/AnyL2WdB1AtsxIIwXG-3a4jDtdMgpHk0lReAnA/mW5ZYPx8BKI.jpg?size=460x427&quality=96&sign=d3b3f0663fef8ae031820a075914b68d&type=album',
      'username': 'Разраб 1',
      'notificationDate': 'May 24, 2024',
      'notificationText': 'Благодарю за скачивание нашего приложения и приветствую в команде, надеюсь ты тут задержишься и все у тебя норм будет кароче, я занимался внешним видом, если есть предложения по его улучшению пишите мне в личку',
    },
    {
      'photoUrl': 'https://sun9-1.userapi.com/impg/uBQ7OID8fStQsq_Dqx3agSnwR4TXvWRrlhRLlw/ssbtev2lBKA.jpg?size=797x1072&quality=96&sign=e8e49262b152ef377df9cf763c97d906&type=album',
      'username': 'Разраб 2',
      'notificationDate': 'May 24, 2024',
      'notificationText': 'Круто кароче все, мне нравится, было интересно полчить такой опыт командной работы, хоть все и не выходило гладко, надеюсь мы продолжим разрабатывать это приложение для вас:)',
    },
    {
      'photoUrl': 'https://sun9-25.userapi.com/impg/1VoTsFaCnhCFlfOyzEmwkiI4yQDsTjt5Hx1iwA/hR6NuncRVNA.jpg?size=800x600&quality=95&sign=659cdc1e484a61c3a9f7a4e6c8c19fc3&type=album',
      'username': 'Разраб 3',
      'notificationDate': 'May 24, 2024',
      'notificationText': 'Вем привет',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((notification) {
        return NotificationTile(
          photoUrl: notification['photoUrl'] ?? '',
          username: notification['username'] ?? '',
          notificationDate: notification['notificationDate'] ?? '',
          notificationText: notification['notificationText'] ?? '',
        );
      }).toList(),
    );
  }
}

class NotificationTile extends StatefulWidget {
  final String photoUrl;
  final String username;
  final String notificationDate;
  final String notificationText;

  NotificationTile({
    required this.photoUrl,
    required this.username,
    required this.notificationDate,
    required this.notificationText,
  });

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    String truncatedText = widget.notificationText.length > 48
        ? widget.notificationText.substring(0, 48) + '...'
        : widget.notificationText;

    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
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
                  backgroundImage: NetworkImage(widget.photoUrl),
                  radius: 25,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.notificationDate,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            AnimatedCrossFade(
              duration: Duration(milliseconds: 300),
              firstChild: Text(
                truncatedText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              secondChild: Text(
                widget.notificationText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
          ],
        ),
      ),
    );
  }
}