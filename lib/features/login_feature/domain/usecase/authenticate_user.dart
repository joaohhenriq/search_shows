import 'package:search_series/features/login_feature/login_feature.dart';

abstract class AuthenticateUser {
  Future<bool> call({required String user, required String password});
}

class AuthenticateUserImpl implements AuthenticateUser {
  AuthenticateUserImpl({required this.loginRepository});

  final LoginRepository loginRepository;

  static const String _expectedCredential = 'admin';

  @override
  Future<bool> call({required String user, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    bool isUserValidated = _isUserValidated(user, password);
    if (isUserValidated) {
      await loginRepository.setUserAsAuthenticated();
    }
    return isUserValidated;
  }

  bool _isUserValidated(String user, String password) {
    return user == _expectedCredential && password == _expectedCredential;
  }
}
