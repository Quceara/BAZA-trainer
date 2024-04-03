import 'package:flutter/material.dart';

class PasswordValidator {
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static bool isPasswordVisible = false;

  // Регулярные выражения для проверки пароля
  static final RegExp regexUpper = RegExp(r'[A-Z]'); // Проверка наличия хотя бы одной заглавной буквы
  static final RegExp regexLower = RegExp(r'[a-z]'); // Проверка наличия хотя бы одной строчной буквы
  static final RegExp regexDigit = RegExp(r'\d'); // Проверка наличия хотя бы одной цифры
  static final RegExp regexSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]'); // Проверка наличия хотя бы одного специального символа
  static final RegExp regexLength = RegExp(r'^.{12,}$'); // Проверка длины пароля (минимум 12 символов)

  static bool isFormValid() {
    String password = passwordController.text;

    return nameController.text.isNotEmpty &&
        password.isNotEmpty &&
        regexUpper.hasMatch(password) &&
        regexLower.hasMatch(password) &&
        regexDigit.hasMatch(password) &&
        regexSpecial.hasMatch(password) &&
        regexLength.hasMatch(password);
  }
}
