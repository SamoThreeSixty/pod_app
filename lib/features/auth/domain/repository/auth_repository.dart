import 'package:fpdart/fpdart.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:supabase/supabase.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signInWithEmailPassword(
      {required String email, required String password});

  Future<Either<Failure, void>> signOut();
}
