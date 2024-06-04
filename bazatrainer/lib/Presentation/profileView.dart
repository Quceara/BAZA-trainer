import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../menu.dart';
import 'bottom_menu.dart';

class ProfilePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const String routeName = '/profileView';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  List<String> imageUrls = [
    'https://sun9-18.userapi.com/impg/PmUbRp_4K_dCdHcIxSR378HEcx7vlv0yCYn9mg/CbDWmeSOl48.jpg?size=1098x830&quality=96&sign=1c2fa5d6c3ddb03a16575b41d9ddead7&type=album1.jpg',
    'https://sun9-3.userapi.com/impg/yIbzQNqbvdz2fCynqKGQDbnZusysN9bQC1_4oA/9E7KeKG5mXE.jpg?size=1087x1090&quality=95&sign=48ba232ee00c2ff17fe8059183adc7d2&type=album2.jpg',
    'https://sun9-60.userapi.com/impg/QRhnGz7N0d4akbCjyGiFHoZggWC516cfEXYS0Q/_ARFm-_6QKE.jpg?size=687x914&quality=96&sign=26914685dc4942d016e99a38d2bad96c&type=album3.jpg',
  ];

  PageController controller = PageController();

  void _selectMenu(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'Серега Пердун',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300,
                      child: PageView.builder(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            imageUrls[index % imageUrls.length],
                            fit: BoxFit.cover,
                          );
                        },
                        itemCount: imageUrls.length,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: controller, // PageController
                          count: imageUrls.length,
                          effect: WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.white,
                            dotColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Color.fromRGBO(15, 15, 15, 1),
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Icon(Icons.emoji_events, color: Color.fromRGBO(255, 199, 0, 1), size: 30),
                          SizedBox(width: 10),
                          Icon(Icons.military_tech, color: Color.fromRGBO(134, 134, 134, 1), size: 30),
                          SizedBox(width: 10),
                          Icon(Icons.military_tech_outlined, color: Color.fromRGBO(134, 134, 134, 1), size: 30),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Действия при нажатии на текст "Редактировать"
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Ред.',
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                Icon(Icons.settings_outlined, color: Colors.white),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Действия при нажатии на текст "Опубликовать"
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Опубл.',
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                Icon(Icons.publish_outlined, color: Colors.white),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'Подписчики',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '123',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Подписки',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '456',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMenuItem(0, 'Характеристики'),
                          _buildMenuItem(1, 'Тренировки'),
                          _buildMenuItem(2, 'Дневники'),
                        ],
                      ),
                    ],
                  ),
                ),
                UserHomePage(),
              ],
            ),
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
              child: BottomMenu(currentIndex: 0),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(27, 27, 27, 1),
      drawer: CustomDrawer(),
      endDrawer: CustomNotification(),
    );
  }
}

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Color.fromRGBO(27, 27, 27, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 2000),
        ],
      ),
    );
  }
}
