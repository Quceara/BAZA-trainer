import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Domain/supabaseCli.dart';

class StorageService {
  final SupabaseClient _client = SupabaseCli().client;

  Future<String?> uploadAvatar(String path, File file) async {
    print("uploadAvatar");
    try {
      final storageResponse = await _client
          .storage
          .from('avatars')
          .upload(path, file);

      if (storageResponse.isNotEmpty) {
        final avatarUrl = _client.storage.from('avatars').getPublicUrl(path);

        // Получаем user_id текущего пользователя
        final userId = _client.auth.currentUser?.id;

        // Сохраняем URL в таблицу avatars
        print(_client.auth.currentUser?.id);

        try {
          final clientResponse = await _client
              .from('client')
              .select('id')
              .eq('user_id', userId as Object)
              .maybeSingle();

          final insertResponse = await _client
              .from('avatars')
              .insert({
            'client_id': clientResponse?['id'],
            'url': avatarUrl,
          }).maybeSingle();

          print(insertResponse);
          return avatarUrl;
        }
        catch (e){
          print("Error inserting avatar URL: $e");
        }
      } else {
        print('Error uploading avatar: ${storageResponse}');
        return null;
      }

      // Печатаем полный ответ, чтобы увидеть его структуру
      print('Storage Response: $storageResponse');

      return storageResponse;
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<String> getAvatarUrl(String path) async {
    final avatarUrl = _client.storage.from('avatars').getPublicUrl(path);
    return avatarUrl;
  }
}
