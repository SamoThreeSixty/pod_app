import 'dart:developer';

import 'package:gotrue/src/types/user.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/features/auth/data/datasources/auth_datasources.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceImp implements AuthDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImp(this._supabaseClient);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _supabaseClient.auth
          .signInWithPassword(password: password, email: email);

      if (response.user == null) throw const ServerException('User is null');

      return response.user!;
    } catch (e) {
      print(e);
      throw const ServerException('Failed to login');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (e) {
      throw const ServerException('Failed to log out');
    }
  }
}
