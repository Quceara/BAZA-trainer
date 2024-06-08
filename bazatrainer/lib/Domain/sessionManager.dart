import 'dart:convert';

import 'package:bazatrainer/Domain/supabaseCli.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final SupabaseClient _client = SupabaseCli().client;

  Session? _session;
  User? _user;

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  Future<void> setSession(Session? session) async {
    print("current session:$session");
    _session = session;
    _user = session?.user;

    if (session != null) {
      final sessionJson = jsonEncode(session.toJson());
      await _secureStorage.write(key: 'session', value: sessionJson);
      await _secureStorage.write(key: 'refresh_token', value: session.refreshToken);
    } else {
      await _secureStorage.delete(key: 'session');
      await _secureStorage.delete(key: 'refresh_token');
    }
  }

  Session? get session => _session;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> signOut() async {
    await _client.auth.signOut();
    _session = null;
    _user = null;
    await _secureStorage.deleteAll();
  }

  Future<void> restoreSession() async {
    final sessionJson = await _secureStorage.read(key: 'session');

    if (sessionJson != null) {
      try {
        final res = await _client.auth.recoverSession(sessionJson);
        if (res.session != null) {
          await setSession(res.session);
          // Проверяем срок действия токена и обновляем его, если он скоро истечет
          final now = DateTime.now();
          final expiryDate = DateTime.fromMillisecondsSinceEpoch(res.session!.expiresAt! * 1000);
          if (now.isAfter(expiryDate.subtract(Duration(minutes: 10)))) {
            await _refreshSession();
          }
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

  Future<void> _refreshSession() async {
    try {
      final refreshToken = await _secureStorage.read(key: 'refresh_token');
      if (refreshToken != null) {
        final res = await _client.auth.refreshSession(refreshToken);
        if (res.session != null) {
          await setSession(res.session);
        } else {
          await signOut();
        }
      } else {
        print("No refresh token found.");
        await signOut();
      }
    } catch (e) {
      print("Error during refreshSession");
      print(e);
      await signOut();
    }
  }
}