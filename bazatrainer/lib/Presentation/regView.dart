import 'package:bazatrainer/Presentation/loginView.dart';

import '../first_launch.dart';
import 'package:flutter/material.dart';
import 'profileView.dart';
import '../calendar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bazatrainer/Domain/sessionManager.dart';
import 'package:bazatrainer/Domain/supabaseCli.dart';
import 'package:bazatrainer/Data/regService.dart';

class regView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'СОЗДАТЬ АККАУНТ',
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
        color: Color.fromRGBO(27, 27, 27, 1),
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
  bool isDatePickerVisible = false;
  int _selectedDay = DateTime.now().day;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  // FocusNode для каждого текстового поля
  FocusNode _nameFocus = FocusNode();
  FocusNode _surnameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    // Освобождаем ресурсы FocusNode
    _nameFocus.dispose();
    _surnameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;
    final surname = _surnameController.text;
    final gender = isButton1Pressed ? 'male' : 'female';
    final birthdate = '$_selectedYear-$_selectedMonth-$_selectedDay';

    final errorMessage = await RegService().register(
      email: email,
      password: password,
      firstName: name,
      secondName: surname,
      gender: gender,
      birthdate: birthdate,
    );

    if (errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Не забудьте подтвердить почту!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => loginView()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 15.0),
                    buildText(_nameController, 'Имя', focusNode: _nameFocus),
                    SizedBox(height: 30.0),
                    buildText(_surnameController, 'Фамилия', focusNode: _surnameFocus),
                    SizedBox(height: 32.0),
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
                    SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDatePickerVisible = !isDatePickerVisible;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Дата рождения",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '$_selectedDay/$_selectedMonth/$_selectedYear',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Container(
                      height: 1.0,
                      color: Colors.white,
                    ),
                    Visibility(
                      visible: !isKeyboardVisible(context) && isDatePickerVisible,
                      child: SizedBox(
                        height: 166,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DatePickerDemo(
                            initialValueDay: _selectedDay,
                            initialValueMonth: _selectedMonth,
                            initialValueYear: _selectedYear,
                            maxYear: DateTime.now().year,
                            onDateChanged: (day, month, year) {
                              setState(() {
                                _selectedDay = day;
                                _selectedMonth = month;
                                _selectedYear = year;
                              });
                            },
                            backgroundColor: Color.fromRGBO(27, 27, 27, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    buildText(_emailController, 'Почта', focusNode: _emailFocus),
                    SizedBox(height: 30.0),
                    buildText(_passwordController, 'Пароль', focusNode: _passwordFocus),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'СЕГОДНЯ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 18.0),
            Text(
              'тот самый день',
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
                fixedSize: Size(100, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: _register,
              child: Text(
                'ПРОДОЛЖИТЬ',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Регистрируясь, ты соглашаешься с Правилами и\nусловиями и подтверждаешь,что ты прочитал(-а) и\nпринимаешь политику конфиденциальности',
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
    );
  }

  bool isKeyboardVisible(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }

  Widget buildText(TextEditingController controller, String label, {FocusNode? focusNode}) {
    return Column(
        children:<Widget>[
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
              focusNode: focusNode,
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
          color: Color.fromRGBO(27, 27, 27, 1),
          border: Border.all(
            color: isPressed ? Colors.white : Colors.white24,
            width: 2.0,
          ),
        ),
        child: SizedBox(
          width: 133,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: isPressed ? Colors.white : Colors.white24,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
