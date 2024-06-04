import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Domain/sessionManager.dart';

class RegService {
  final String supabaseUrl = 'https://fpttqwzlyoaqwyxjpxlj.supabase.co';
  final String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZwdHRxd3pseW9hcXd5eGpweGxqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIzMzExMjAsImV4cCI6MjAyNzkwNzEyMH0.tgHK9DgkQv7x-zpZfYDHaa_78S60Bfh22GyXQiP0qfY';

  Future<String?> register({
    required String email,
    required String password,
    required String firstName,
    required String secondName,
    required String gender,
    required String birthdate,
  }) async {
    final url = Uri.parse('$supabaseUrl/auth/v1/signup');
    final headers = {
      'Content-Type': 'application/json',
      'apikey': supabaseKey,
      'Authorization': 'Bearer $supabaseKey',
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Response body: $responseBody');

        final userId = responseBody['id'];
        if (userId == null) {
          return 'Ошибка: не удалось получить ID пользователя';
        }
        print('User ID: $userId');

        // Сохранение дополнительной информации в таблицу client
        final profileUrl = Uri.parse('$supabaseUrl/rest/v1/client');
        final profileBody = jsonEncode({
          'user_id': userId,
          'first_name': firstName,
          'second_name': secondName,
          'gender': gender,
          'birthdate': birthdate,
        });

        final profileResponse = await http.post(profileUrl, headers: {
          'Content-Type': 'application/json',
          'apikey': supabaseKey,
          'Authorization': 'Bearer $supabaseKey',
          'Prefer': 'return=minimal',
        }, body: profileBody);

        if (profileResponse.statusCode == 201) {
          // Выполнение входа после успешной регистрации
          // final signInResponse = await Supabase.instance.client.auth.signInWithPassword(
          //   email: email,
          //   password: password,
          // );

          // if (signInResponse.error != null) {
          //   return 'Ошибка создания сессии: ${signInResponse.error?.message}';
          // } else {
          //   SessionManager().setSession(signInResponse.session);
            return null; // Регистрация успешна
          // }
        } else {
          print('Error saving profile: ${profileResponse.statusCode}');
          print('Body: ${profileResponse.body}');
          return 'Ошибка сохранения профиля: ${profileResponse.body}';
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
        return 'Ошибка регистрации: ${response.body}';
      }
    } catch (e) {
      return "Не понятная ошибка: ${e.toString()}";
    }
  }
}
