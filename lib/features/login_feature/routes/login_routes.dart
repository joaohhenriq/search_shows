import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_series/base_app/injection/injection.dart';
import 'package:search_series/base_app/router/router.dart';
import 'package:search_series/features/login_feature/login_feature.dart';

class LoginRouter implements RouterClient {
  @override
  Map<String, dynamic> getRoutes(RouteSettings settings) => {
        LoginRoutes.loginPage: MaterialPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (_) => LoginState(),
            child: LoginPage(
              authenticateUser: Injector.I.get(),
            ),
          ),
        ),
      };
}

class LoginRoutes {
  static const loginPage = 'login_page';
}
