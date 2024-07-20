import 'package:flutter/material.dart';

class LoginState extends ChangeNotifier {
  bool loading = false;

  void updateLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}