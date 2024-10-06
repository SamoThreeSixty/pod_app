import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// Domain usecase
import 'package:pod_app/features/auth/domain/usecase/sign_in_with_email_password.dart';
import 'package:pod_app/features/auth/domain/usecase/sign_out.dart';

// Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

// BLoC setup
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailPassword _signInWithEmailPassword;
  final SignOut _signOut;

  AuthBloc({
    required SignInWithEmailPassword signInWithEmailPassword,
    required SignOut signOut,
  })  : _signInWithEmailPassword = signInWithEmailPassword,
        _signOut = signOut,
        super(AuthInitial()) {
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading());

      final user = await _signInWithEmailPassword(
        UserSignInParams(email: event.email, password: event.password),
      );

      user.fold((error) {
        emit(
          AuthFailure(error.message),
        );
      }, (result) {
        emit(
          AuthLoggedIn(result),
        );
      });
    });

    on<AuthSignOut>((event, emit) async {
      final result = _signOut;

      emit(AuthSignedOut());
    });
  }
}
