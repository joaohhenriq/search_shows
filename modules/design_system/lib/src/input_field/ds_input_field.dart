import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DsInputField extends StatelessWidget {
  const DsInputField({
    required this.controller,
    this.hintText = '',
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) => TextFormField(
        key: key,
        validator: validator,
        controller: controller,
        cursorColor: DsColors.textDark,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        style: DsTypography.textRegular.copyWith(
          fontSize: 18,
          color: DsColors.inputValueColor,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? _buildPrefixIcon(prefixIcon!) : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DsSpacing.xs,
            vertical: DsSpacing.xs,
          ),
          hintText: hintText,
          hintStyle: DsTypography.textRegular.copyWith(
            fontSize: 18,
            color: DsColors.inputHintColor,
          ),
          enabledBorder: _buildBorder(DsColors.inputBorderColorLight),
          focusedBorder: _buildBorder(DsColors.inputBorderColorDark),
          errorBorder: _buildBorder(DsColors.inputBorderColorError),
          focusedErrorBorder: _buildBorder(DsColors.inputBorderColorError),
        ),
      );

  OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      );

  Widget _buildPrefixIcon(IconData iconData) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(iconData, color: DsColors.inputHintColor),
      );
}
