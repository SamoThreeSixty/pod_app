import 'package:fpdart/src/either.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:pod_app/core/event/events.dart';
import 'package:pod_app/core/usecase/auth/data/datasources/auth_datasources.dart';
import 'package:pod_app/core/usecase/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pod_app/core/usecase/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource remoteDataSource;
  const AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(email, password);

      return right(user);
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
