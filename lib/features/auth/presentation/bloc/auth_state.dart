part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoggedIn extends AuthState {
  final User user;
  AuthLoggedIn(this.user);
}

final class AuthSignedOut extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
