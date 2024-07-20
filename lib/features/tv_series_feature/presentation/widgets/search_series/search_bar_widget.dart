import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onTap,
    required this.loading,
    required this.labelText,
  });

  final TextEditingController controller;
  final void Function() onTap;
  final bool loading;
  final String labelText;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: DsSpacing.xxs,
          left: DsSpacing.xxs,
          right: DsSpacing.xxs,
        ),
        child: Padding(
          padding: const EdgeInsets.all(DsSpacing.xxs),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: DsSpacing.xxxs),
                  child: DsInputField(
                    controller: controller,
                    onFieldSubmitted: (_) => loading ? () {} : onTap(),
                    hintText: labelText,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: loading ? () {} : onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: DsColors.blue,
                ),
                child: Text(
                  'Search',
                  style: TextStyle(color: DsColors.white),
                ),
              ),
            ],
          ),
        ),
      );
}
