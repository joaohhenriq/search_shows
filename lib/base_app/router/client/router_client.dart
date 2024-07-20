import 'package:flutter/material.dart';

abstract class RouterClient {
  Map<String, dynamic> getRoutes(RouteSettings settings);
}


