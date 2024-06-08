import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final SupabaseClient _client;

  UserService(this._client);

  Future<List<dynamic>?> getUserData(String userId) async {
    try {
      final responseCommon = await _client
          .from('client')
          .select('id, first_name, second_name, profile(subscribers,subscribe)')
          .eq('user_id', userId)
          .single();

      final responseAvatars = await _client
          .from('avatars')
          .select('url, uploaded_at')
          .eq('client_id', responseCommon['id']);

      print("common: $responseCommon");
      print("avatars: $responseAvatars");

      return [responseCommon, responseAvatars];
    } catch (e) {
      print('Error loading user data: $e');
      return null;
    }
  }
}
