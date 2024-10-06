import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/usecase.dart';
import 'package:pod_app/core/usecase/auth/domain/repository/auth_repository.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInWithEmailPassword implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;

  SignInWithEmailPassword(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailPassword(
        password: params.password, email: params.email);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
