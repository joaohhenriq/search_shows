import 'package:either_dart/either.dart';
import 'package:search_series/features/login_feature/login_feature.dart';
import 'package:search_series/features_util/failure.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required this.datasource});

  final LoginLocalDataSource datasource;

  @override
  Future<Either<Failure, bool>> setUserAsAuthenticated() async {
    try {
      final success = await datasource.setUserAsAuthenticated();
      return Right(success);
    } on Exception {
      return Left(SetUserAsAuthenticatedFailure());
    }
  }
}
