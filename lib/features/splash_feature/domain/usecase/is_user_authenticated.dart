import 'package:either_dart/either.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';
import 'package:search_series/features_util/failure.dart';

abstract class IsUserAuthenticated {
  Future<Either<Failure, bool>> call();
}

class IsUserAuthenticatedImpl implements IsUserAuthenticated {
  IsUserAuthenticatedImpl({required this.repository});

  final SplashRepository repository;

  @override
  Future<Either<Failure, bool>> call() async =>
      await repository.isUserAuthenticated();
}
