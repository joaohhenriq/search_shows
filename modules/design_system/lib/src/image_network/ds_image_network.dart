import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    super.key,
    required this.imageUrl,
    required this.defaultIconColor,
  });

  final String imageUrl;
  final Color defaultIconColor;

  @override
  Widget build(BuildContext context) => imageUrl.isNotEmpty
      ? Image.network(
          imageUrl,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          fit: BoxFit.cover,
        )
      : Icon(
          Icons.image_not_supported,
          color: defaultIconColor,
        );
}
