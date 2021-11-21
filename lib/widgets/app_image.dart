import 'package:flutter/material.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/index.dart';

class AppImage extends StatelessWidget {
  final String imageURL;
  final double? height;
  final double? width;
  final BoxFit fit;
  const AppImage(
      {Key? key,
      required this.imageURL,
      this.height,
      this.width,
      this.fit = BoxFit.contain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageURL,
      height: height,
      width: width,
      filterQuality: FilterQuality.high,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: AppLoading(
            scale: 0.5,
            color: AppColors.primaryL,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      fit: fit,
    );
  }
}
