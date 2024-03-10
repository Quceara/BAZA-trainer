import 'package:flutter/material.dart';
import 'profile.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(33, 33, 33, 1), // Серый фон
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  bool isButton1Pressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction, // Включаем авто-валидацию
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50.0),
            Text('СОЗДАТЬ АККАУНТ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 50.0),
            buildText(_nameController, 'Имя'),
            buildText(_surnameController, 'Фамилия'),
            Align(
              alignment: Alignment.centerLeft,
              child:
              Text(
                'Пол',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                BuildCustomButton(
                  buttonText: 'Мужчина',
                  onPressed: () {
                    setState(() {
                      isButton1Pressed = true;
                    });
                  },
                  isPressed: isButton1Pressed,
                ),
                // Вторая кнопка
                SizedBox(width: 10.0),
                BuildCustomButton(
                  buttonText: 'Женщина',
                  onPressed: () {
                    setState(() {
                      isButton1Pressed = false;
                    });
                  },
                  isPressed: !isButton1Pressed,
                ),
              ],
            ),
            SizedBox(height: 2.0),
            buildText(_emailController, 'Email'),
            buildText(_passwordController, 'Пароль'),
            SizedBox(height: 30.0),
            Text('СЕГОДНЯ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 15.0),
            Text('тот самый день',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                fixedSize: Size(100, 55)
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
                // if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                //   // Отправить данные регистрации
                //   String name = _nameController.text;
                //   String surname = _surnameController.text;
                //   String email = _emailController.text;
                //   String password = _passwordController.text;
                //   if (name.trim().isEmpty || surname.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
                //     // Если какое-то поле не заполнено, выдаем сообщение и не отправляем форму
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('Пожалуйста заполните все поля!')),
                //     );
                //   } else {
                //     // Здесь вы можете выполнить логику регистрации
                //     // Например, отправить запрос на сервер или выполнить локальное сохранение
                //     // после чего перейти на другой экран
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => RegistrationSuccessScreen(),
                //       ),
                //     );
                //   }
                // }
              },
              child: Text('Ебашить',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Success'),
      ),
      body: Center(
        child: Text('Registration Successful!'),
      ),
    );
  }
}

Widget buildText(TextEditingController controller, String label) {
  return Column(
    children:<Widget>
    [
      Align(
        alignment: Alignment.centerLeft,
        child:
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

      ),
      SizedBox(height: 2.0),
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          color: Color.fromRGBO(33, 33, 33, 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child:
        TextFormField(
          controller: controller,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(12, 1, 1, 1), // Подгоняем значения отступов
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    ]
  );
}
Widget BuildCustomButton({
  required String buttonText,
  required VoidCallback onPressed,
  required bool isPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(

      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isPressed ? Colors.green : Colors.grey, // Изменяем цвет кнопки в зависимости от состояния
      ),
      child: SizedBox(
        width: 136,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      )
    ),
  );
}
