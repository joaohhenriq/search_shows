import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_series/features/login_feature/login_feature.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.authenticateUser,
    super.key,
  });

  final AuthenticateUser authenticateUser;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login', style: DsTypography.textMedium)),
      body: Padding(
        padding: const EdgeInsets.all(DsSpacing.s),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: DsSpacing.s),
                child: DsInputField(
                  controller: _usernameController,
                  hintText: 'User',
                  prefixIcon: Icons.person,
                  validator: (value) => _inputValidator(
                    value,
                    'Please enter a valid username',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: DsSpacing.s),
                child: DsInputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  validator: (value) => _inputValidator(
                    value,
                    'Please enter a valid password',
                  ),
                ),
              ),
              Consumer<LoginState>(
                builder: (context, provider, child) {
                  return DsButton(
                    text: 'Login',
                    loading: provider.loading,
                    onTap: () => _onTapButton(
                      user: _usernameController.text.trim(),
                      password: _passwordController.text.trim(),
                      updateLoading: provider.updateLoading,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _inputValidator(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  Future<void> _onTapButton({
    required String user,
    required String password,
    required void Function(bool) updateLoading,
  }) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      updateLoading(true);
      final result = await widget.authenticateUser(
        user: user,
        password: password,
      );
      updateLoading(false);
      if (result) {
        await Navigator.pushReplacementNamed(context, '/tv_series');
      } else {
        showDialog(
          context: context,
          builder: (context) => const DsAlertDialog(
            title: 'Error',
            content: 'Invalid username or password',
          ),
        );
      }
    }
  }
}
