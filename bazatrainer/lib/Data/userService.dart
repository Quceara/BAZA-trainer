import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final SupabaseClient _client;

  UserService(this._client);

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final response = await _client
          .from('client')
          .select('first_name, second_name, profile(subscribers,subscribe)')
          .eq('user_id', userId)
          .single();

      return response;
    } catch (e) {
      print('Error loading user data: $e');
      return null;
    }
  }
}
