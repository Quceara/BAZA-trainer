import 'package:flutter/material.dart';
import 'registration.dart';
import 'Presentation/loginView.dart';

class FirstLaunchBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pictures/Geraklit.png'), // Замените на своё фото
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Фото заместо фона
                // Для кнопки "НАЧАТЬ"
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                  },
                  child: Text(
                    'НАЧАТЬ',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Цвет кнопки
                    fixedSize: Size(300, 50),
                  ),
                ),
                SizedBox(height: 20), // Пространство между кнопкой и текстом
                // Текст "Уже есть аккаунт"
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => loginView(),
                      ),
                    );
                  },
                  child: Text(
                    'Уже есть аккаунт?',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
