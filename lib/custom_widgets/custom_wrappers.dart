import 'dart:io';

import 'package:flutter/material.dart';
import '../../theme/my_app_colors.dart';
import '../../service_locator.dart';
import '../custom_utils/image_helper.dart';

//Theme
final AppColors _appColor = getIt<AppColors>();

Widget customContainer(
    {double? height,
    double? width,
    required Widget child,
    EdgeInsetsGeometry? padding}) {
  return Container(
    height: height,
    width: width,
    padding: padding,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: _appColor.accentColorLight,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ]),
    child: child,
  );
}

Widget customImageBox(double width, ThemeData _theme,
    {required String image,
    required String title,
    double? price,
    Function()? onTap}) {
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  ImageType imageType = _customImageHelper.getImageType(image);

  return InkWell(
    onTap: onTap,
    child: customContainer(
      child: Column(
        children: [
          imageType == ImageType.file
              ? Image.file(
                  File(image),
                  width: width * 0.9,
                  height: width * 0.9,
                  fit: BoxFit.cover,
                )
              : (imageType == ImageType.network
                  ? Image.network(
                      image,
                      width: width * 0.9,
                      height: width * 0.9,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      image,
                      width: width * 0.9,
                      height: width * 0.9,
                      fit: BoxFit.cover,
                    )),
          const SizedBox(height: 10),
          Text(
            title,
            style: _theme.textTheme.headline4,
          ),
          price != null
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '\$ $price',
                      style: _theme.textTheme.headline4,
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    ),
  );
}

Widget buildImage(ThemeData theme, String imagePath) {
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  ImageType imageType = _customImageHelper.getImageType(imagePath);

  final Widget returnAble = imagePath.isEmpty
      ? const SizedBox()
      : (imageType == ImageType.network
          ? Image.network(
              imagePath,
              fit: BoxFit.cover,
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
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Icon(
                  Icons.error,
                  color: theme.colorScheme.error,
                );
              },
            )
          : (imageType == ImageType.file
              ? Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Icon(
                      Icons.error,
                      color: theme.colorScheme.error,
                    );
                  },
                )
              : Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Icon(
                      Icons.error,
                      color: theme.colorScheme.error,
                    );
                  },
                )));

  return returnAble;
}
