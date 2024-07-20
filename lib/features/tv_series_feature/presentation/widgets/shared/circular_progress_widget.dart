import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({super.key});

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(DsColors.blue),
    strokeWidth: 2,
  );
}
