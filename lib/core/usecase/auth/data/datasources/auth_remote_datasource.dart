import 'dart:developer';

import 'package:gotrue/src/types/user.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/auth/data/datasources/auth_datasources.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Event Log
import 'package:pod_app/features/event/data/database/event_log_dto.dart';
import 'package:pod_app/features/event/data/database/event_log_database.dart';

class AuthRemoteDataSourceImp implements AuthDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImp(this._supabaseClient);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _supabaseClient.auth
          .signInWithPassword(password: password, email: email);

      if (response.user == null) throw const ServerException('User is null');

      final EventLogDto eventLog = EventLogDto(
        EventDate: DateTime.now(),
        Operation: 'Operation',
        Description: 'User $email logged in successfully',
        UserID: 0,
      );

      EventLogDatabase.instance.create(eventLog);

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

      final EventLogDto eventLog = EventLogDto(
        EventDate: DateTime.now(),
        Operation: 'Operation',
        Description: 'User logged out successfully',
        UserID: 0,
      );

      EventLogDatabase.instance.create(eventLog);
    } catch (e) {
      throw const ServerException('Failed to log out');
    }
  }
}
