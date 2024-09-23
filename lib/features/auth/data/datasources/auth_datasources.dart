import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource {
  Future<User?> login(String username, String password);
  Future<void> logout();
}
