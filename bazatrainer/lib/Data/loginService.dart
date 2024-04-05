
import 'package:bazatrainer/Domain/sessionManager.dart';
import 'package:bazatrainer/Domain/supabaseCli.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  Future<String?> login(String email, String password) async {
    try {
      final res = await SupabaseCli().client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // Если ошибки нет, сохраняем сессию и возвращаем null
      SessionManager().setSession(res.session);
      return null;

    } catch (e) {
      // Если произошло исключение типа AuthException, выводим его сообщение
      if (e is AuthException) {
        return "Неверные данные для входа"; // Здесь получаем сообщение об ошибке
      } else {
        // Для других типов исключений возвращаем их строковое представление
        return e.toString();
      }
    }
  }
}

