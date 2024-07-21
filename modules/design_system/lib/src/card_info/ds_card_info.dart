import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DsCardInfo extends StatelessWidget {
  const DsCardInfo({
    super.key,
    required this.onTap,
    required this.title,
    required this.description,
    required this.mediumImage,
    this.height = 100,
    this.width = 100,
  });

  final String title;
  final String description;
  final String mediumImage;
  final void Function() onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: DsColors.backgroundColorTertiary,
            boxShadow: [
              BoxShadow(
                color: DsColors.backgroundColorTertiary,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: ImageNetwork(
                    imageUrl: mediumImage,
                    defaultIconColor: DsColors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DsSpacing.xxs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: DsSpacing.xxxs),
                        child: Text(
                          title.isNotEmpty ? title : 'No title available',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: DsTypography.textMedium.copyWith(
                            color: DsColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (description.isNotEmpty)
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: DsTypography.textRegular.copyWith(
                            color: DsColors.white.withOpacity(0.5),
                            fontSize: 15,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: DsSpacing.xxs),
                child: Icon(
                  Icons.chevron_right,
                  color: DsColors.white,
                ),
              ),
            ],
          ),
        ),
      );
}
