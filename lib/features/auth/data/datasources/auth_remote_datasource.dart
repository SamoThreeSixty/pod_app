import 'package:gotrue/src/types/user.dart';
import 'package:pod_app/features/auth/data/datasources/auth_datasources.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasource implements AuthDatasources {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasource(this.supabaseClient);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);

      if (response.user != null) {
        return response.user!;
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to login');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw Exception('Failed to log out');
    }
  }
}
