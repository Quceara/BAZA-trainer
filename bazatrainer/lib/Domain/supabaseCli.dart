import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCli {
  static final SupabaseCli _instance = SupabaseCli._internal();

  final SupabaseClient client;

  factory SupabaseCli() => _instance;

  SupabaseCli._internal()
      : client = SupabaseClient(
    'https://fpttqwzlyoaqwyxjpxlj.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZwdHRxd3pseW9hcXd5eGpweGxqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIzMzExMjAsImV4cCI6MjAyNzkwNzEyMH0.tgHK9DgkQv7x-zpZfYDHaa_78S60Bfh22GyXQiP0qfY',
  );
}