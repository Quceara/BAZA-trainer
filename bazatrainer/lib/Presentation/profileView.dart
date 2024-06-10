import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Data/storageService.dart';
import '../Data/userService.dart';
import '../Domain/supabaseCli.dart';
import '../menu.dart';
import '../Domain/sessionManager.dart';
import 'bottom_menu.dart';


class ProfilePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const String routeName = '/profileView';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SessionManager _sessionManager;
  late UserService _userService;
  late StorageService _storageService;
  List<dynamic>? _userData;
  Map<String, dynamic>? _userDataCommon;
  List<Map<String, dynamic>>? _userDataAvatars;
  List<String> imageUrls = [ 'https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png'];

  @override
  void initState() {
    super.initState();
    _sessionManager = SessionManager();
    _userService = UserService();
    _storageService = StorageService();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_sessionManager.user != null) {
      final userId = _sessionManager.user!.id;
      final userData = await _userService.getUserData();
      setState(() {
        _userData = userData;
        _userDataCommon = userData?[0];
        _userDataAvatars = userData?[1];

        if (_userDataAvatars != null && _userDataAvatars!.isNotEmpty) {
          imageUrls = _userDataAvatars!
              .map<String>((avatar) => avatar['url'] as String)
              .toList();
          imageUrls = imageUrls.reversed.toList();
        } else {
          imageUrls = [
            'https://i2.wp.com/vdostavka.ru/wp-content/uploads/2019/05/no-avatar.png'
          ];
        }

        print(_userDataAvatars != null && _userDataAvatars!.isNotEmpty);
        print(_userDataAvatars);
      });
    }
  }

  int _selectedIndex = 0;



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

  Future<void> _uploadAvatar(BuildContext context) async {
    final picker = ImagePicker();

    // Запрашиваем разрешение
    if (await Permission.photos.request().isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      try {
        if (pickedFile != null) {
          final file = File(pickedFile.path);
          final fileName = '${_sessionManager.user!.id}-${file.path.split('/').last}';
          final uploadPath = await _storageService.uploadAvatar(fileName, file);
          if (uploadPath != null) {
            print('Avatar uploaded to: $uploadPath');
            // Обновляем UI, если необходимо
            _loadUserData();
          } else {
            print('Failed to upload avatar');
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to upload avatar'))
            );
          }
        } else {
          print('No image selected');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No image selected'))
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'))
        );
      }
    } else if (await Permission.photos.isPermanentlyDenied) {
      openAppSettings();
    } else {
      // Выводим сообщение, если разрешение не предоставлено
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission not granted to access photos'))
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    print(imageUrls);
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          _userDataCommon != null ? '${_userDataCommon!['first_name']} ${_userDataCommon!['second_name']}' : 'Загрузка...',
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
                    GestureDetector(
                      child: Container(
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
                      onDoubleTap: () async {
                        _uploadAvatar(context);
                      },
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
                  child: const Column(
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
                                _userDataCommon != null ? '${_userDataCommon!['profile'][0]['subscribers']}' : '?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
                                _userDataCommon != null ? '${_userDataCommon!['profile'][0]['subscribe']}' : '?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
