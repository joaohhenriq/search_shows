import 'package:either_dart/either.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';
import 'package:search_series/features_util/failure.dart';

abstract class GetTvSeriesById {
  Future<Either<Failure, TvShowEntity>> call(int id);
}

class GetTvSeriesByIdImpl implements GetTvSeriesById {
  GetTvSeriesByIdImpl(this.repository);

  final TvSeriesRepository repository;

  @override
  Future<Either<Failure, TvShowEntity>> call(int id) async =>
      await repository.getTvSeriesById(id);
}
