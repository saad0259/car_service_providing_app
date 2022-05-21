import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
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
        borderRadius: BorderRadius.circular(20.0),
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
    Key? key,
    required String title,
    double? price,
    Function()? onTap}) {
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  ImageType imageType = _customImageHelper.getImageType(image);

  return InkWell(
    key: key,
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
                  ? CachedNetworkImage(
                      imageUrl: image,
                      width: width * 0.9,
                      height: width * 0.9,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator.adaptive(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
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
          ? CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
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
