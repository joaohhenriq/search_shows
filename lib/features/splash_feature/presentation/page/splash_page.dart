// ignore_for_file: use_build_context_synchronously
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:search_series/features/login_feature/login_feature.dart';
import 'package:search_series/features/splash_feature/splash_feature.dart';
import 'package:search_series/features/tv_series_feature/tv_series_feature.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    required this.isUserAuthenticated,
    super.key,
  });

  final IsUserAuthenticated isUserAuthenticated;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _sizeAnimation = Tween<double>(begin: 50.0, end: 100.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      await _isUserAuthenticated();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DsColors.backgroundColorPrimary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: DsSpacing.s),
                child: AnimatedBuilder(
                  animation: _sizeAnimation,
                  builder: (context, child) {
                    return SizedBox(
                      width: _sizeAnimation.value,
                      height: _sizeAnimation.value,
                      child: const FlutterLogo(),
                    );
                  },
                ),
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Welcome to TV Series App',
                  style: DsTypography.textSemiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _isUserAuthenticated() async {
    final result = await widget.isUserAuthenticated();
    final route = result.isRight && result.right
        ? TvSeriesRoutes.tvSeriesPage
        : LoginRoutes.loginPage;

    await Navigator.pushReplacementNamed(context, route);
  }
}
