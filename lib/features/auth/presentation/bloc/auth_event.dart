part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn(
    this.email,
    this.password,
  );
}

final class AuthSignOut extends AuthEvent {}
