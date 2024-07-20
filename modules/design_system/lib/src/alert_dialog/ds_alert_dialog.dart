import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DsAlertDialog extends StatelessWidget {
  const DsAlertDialog({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) => AlertDialog(
        backgroundColor: DsColors.alertErrorBackground,
        title: Text(
          title,
          style: DsTypography.textRegular.copyWith(
            color: DsColors.alertErrorText,
          ),
        ),
        content: Text(
          content,
          style: DsTypography.textRegular.copyWith(
            color: DsColors.alertErrorText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: DsTypography.textRegular.copyWith(
                color: DsColors.alertErrorText,
              ),
            ),
          ),
        ],
      );
}
