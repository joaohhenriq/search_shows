import 'package:get_it/get_it.dart';
import 'package:search_series/base_app/injection/injection.dart';

final _getIt = GetIt.instance;

class Injector implements InjectionClient {
  Injector._();

  static InjectionClient? _internal;

  static InjectionClient get I => _instance;

  static InjectionClient get _instance {
    _internal ??= Injector._();
    return _internal!;
  }

  @override
  T get<T extends Object>() => _getIt.get<T>();

  @override
  void registerFactory<T extends Object>(T Function() function) {
    _getIt.registerFactory<T>(() => function.call());
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() function) {
    _getIt.registerLazySingleton<T>(() => function.call());
  }

  @override
  void registerSingleton<T extends Object>(T instance) =>
      _getIt.registerSingleton<T>(instance);
}
