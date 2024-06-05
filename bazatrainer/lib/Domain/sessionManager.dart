import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Session? _session;
  User? _user;

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  Future<void> setSession(Session? session) async {
    _session = session;
    _user = session?.user;

    if (session != null) {
      final sessionJson = jsonEncode(session.toJson());
      await _secureStorage.write(key: 'session', value: sessionJson);
    } else {
      await _secureStorage.delete(key: 'session');
    }
  }

  Session? get session => _session;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    _session = null;
    _user = null;
    await _secureStorage.deleteAll();
  }

  Future<void> restoreSession() async {
    final sessionJson = await _secureStorage.read(key: 'session');
    print("Session JSON: $sessionJson");

    if (sessionJson != null) {
      try {
        final sessionData = jsonDecode(sessionJson);
        final res = await Supabase.instance.client.auth.recoverSession(sessionJson);
        print("recoverSession res");
        print(res);
        print("recoverSession res");
        if (res.session != null) {
          await setSession(res.session);
        } else {
          await signOut();
        }
      } catch (e) {
        print("Error during recoverSession");
        print(e);
        await signOut();
      }
    } else {
      print("No session found.");
    }
  }
}
