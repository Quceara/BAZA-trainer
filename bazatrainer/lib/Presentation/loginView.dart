import 'package:bazatrainer/Domain/supabaseCli.dart';
import 'package:flutter/material.dart';
import '../profile.dart';
import '../first_launch.dart';
import '../Domain/password_validator.dart'; // Импортируем файл с регулярными выражениями

class loginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ВХОД',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromRGBO(27, 27, 27, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FirstLaunchBuild(),
              ),
            );
          },
        ),
      ),
      body: Container(
        color: Color.fromRGBO(27, 27, 27, 1), // Серый фон
        child: loginForm(),
      ),
    );
  }
}

class loginForm extends StatefulWidget {
  @override
  _loginFormState createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 15.0),
                  buildText(PasswordValidator.nameController, 'Почта'),
                  SizedBox(height: 20.0),
                  buildPasswordText(PasswordValidator.passwordController, 'Пароль'),
                  SizedBox(height: 10.0),
                  const Row(
                    children: [
                      Text('Минимум 12 знаков, включая 1 строчную и заглавную букву,\n1 спец-символ и 1 цифру',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 11
                        ),
                      ),
                      SizedBox(height: 30,)
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              fixedSize: Size(100, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            onPressed: () {
              // loginService

              SupabaseCli scli = SupabaseCli();

              // scli.client.auth();



              if (PasswordValidator.isFormValid()) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Пожалуйста, заполните все поля и убедитесь, что пароль соответствует требованиям'),
                  ),
                );
              }
            },
            child: Text(
              'ПРОДОЛЖИТЬ',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: Text(
                  'Забыли пароль?',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 18.0
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 45,)
        ],
      ),
    );
  }

  Widget buildText(TextEditingController controller, String label) {
    return Column(
      children: <Widget>[
        SizedBox(height: 2.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            color: Colors.transparent,
          ),
          child: TextFormField(
            controller: controller,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                  color: Colors.white,
                  backgroundColor: Color.fromRGBO(27, 27, 27, 1)
              ),
              contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              errorStyle: TextStyle(height: 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordText(TextEditingController controller, String label) {
    return Column(
      children: <Widget>[
        SizedBox(height: 2.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            color: Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: controller,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(27, 27, 27, 1),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorStyle: TextStyle(height: 0),
                ),
                obscureText: !PasswordValidator.isPasswordVisible,
              ),
              IconButton(
                icon: Icon(
                  PasswordValidator.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    PasswordValidator.isPasswordVisible = !PasswordValidator.isPasswordVisible;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
