import 'package:bazatrainer/Domain/sessionManager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Domain/supabaseCli.dart';

class UserService {
  final SupabaseClient _client = SupabaseCli().client;

  Future<List<dynamic>?> getUserData() async {
    final userId = SessionManager().user!.id;
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

      return [responseCommon, responseAvatars];
    } catch (e) {
      print('Error loading user data: $e');
      return null;
    }
  }

  Future<String> getUserName() async {
    final userId = SessionManager().user!.id;
    try {
      final responseCommon = await _client
          .from('client')
          .select('first_name, second_name')
          .eq('user_id', userId)
          .single();

      return "${responseCommon['first_name']} ${responseCommon['second_name']}";
    } catch (e) {
      print('Error loading user data: $e');
      return "null";
    }
  }
}
