import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  const CenteredText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(text, style: DsTypography.textRegular),
        ),
      );
}
