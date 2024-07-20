import 'package:either_dart/either.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';
import 'package:search_series/features_util/failure.dart';

class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl({required this.datasource});

  final SplashDataSource datasource;

  @override
  Future<Either<Failure, bool>> isUserAuthenticated() async {
    try {
      final isUserAuthenticated = await datasource.isUserAuthenticated();
      return Right(isUserAuthenticated);
    } on Exception {
      return Left(IsUserAuthenticatedFailure());
    }
  }
}
