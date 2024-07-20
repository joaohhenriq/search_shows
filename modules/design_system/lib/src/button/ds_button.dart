import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DsButton extends StatelessWidget {
  const DsButton({
    required this.text,
    required this.loading,
    required this.onTap,
    super.key,
  });

  final String text;
  final bool loading;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: loading ? null : onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: DsColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            border: Border.all(
              color: DsColors.blue,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: DsSpacing.xs),
          child: Center(
            child: loading
                ? SizedBox(
                    height: 20,
                    width: 20,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(DsColors.blue),
                      strokeWidth: 2,
                    ),
                )
                : Text(
                    text,
                    style: DsTypography.textMedium.copyWith(
                      fontSize: 16,
                      color: DsColors.blue,
                    ),
                  ),
          ),
        ),
      );
}
