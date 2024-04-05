import 'package:supabase_flutter/supabase_flutter.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  Session? _session;
  User? _user;

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  void setSession(Session? session) {
    _session = session;
    _user = session?.user;
  }

  Session? get session => _session;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  // Возможные дополнительные методы для работы с сессией
  // ...

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    _session = null;
    _user = null;
  }
}
