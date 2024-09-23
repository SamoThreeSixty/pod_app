import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDatasources {
  Future<User?> login(String username, String password);
  Future<void> logout();
}

class AuthDatasourcesImp implements AuthDatasources {
  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
