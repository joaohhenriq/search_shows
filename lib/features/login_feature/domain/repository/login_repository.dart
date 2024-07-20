import 'package:either_dart/either.dart';
import 'package:search_series/features_util/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> setUserAsAuthenticated();
}
