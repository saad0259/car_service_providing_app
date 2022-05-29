import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../theme/my_app_colors.dart';
import '../../service_locator.dart';
import '../custom_utils/image_helper.dart';

//Theme
final AppColors _appColor = getIt<AppColors>();

Widget customCard({
  double? height,
  double? width,
  required Widget child,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
}) {
  return Container(
    height: height,
    width: width,
    margin: margin ?? const EdgeInsetsDirectional.only(bottom: 20),
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

Widget customImageBox(double width, ThemeData theme,
    {required String image,
    Key? key,
    required String title,
    double? price,
    Function()? onTap}) {
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  ImageType imageType = _customImageHelper.getImageType(image);
  double imageHeight = 200;
  const BoxFit customFit = BoxFit.cover;

  return InkWell(
    key: key,
    onTap: onTap,
    child: customCard(
      child: Column(
        children: [
          imageType == ImageType.file
              ? Image.file(
                  File(image),
                  // width: width * 0.9,
                  height: imageHeight,
                  fit: customFit,
                )
              : (imageType == ImageType.network
                  ? CachedNetworkImage(
                      imageUrl: image,
                      // width: width * 0.9,
                      height: imageHeight,
                      fit: customFit,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator.adaptive(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    )
                  : Image.asset(
                      image,
                      // width: width * 0.9,
                      height: imageHeight,
                      fit: customFit,
                    )),
          const SizedBox(height: 10),
          Text(
            title,
            style: theme.textTheme.headline4,
          ),
          price != null
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '\$ $price',
                      style: theme.textTheme.headline4,
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    ),
  );
}

Widget buildImage(ThemeData theme, String imagePath,
    {double? height, double? width}) {
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  ImageType imageType = _customImageHelper.getImageType(imagePath);
  const BoxFit customFit = BoxFit.cover;

  final Widget returnAble = imagePath.isEmpty
      ? const SizedBox()
      : (imageType == ImageType.network
          ? CachedNetworkImage(
              imageUrl: imagePath,
              fit: customFit,
              height: height,
              width: width,
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
                  height: height,
                  width: width,
                  fit: customFit,
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
                  height: height,
                  width: width,
                  fit: customFit,
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

Widget customImageCircle(
  ThemeData theme,
  String source, {
  double radius = 100,
  VoidCallback? onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2000),
        child: buildImage(
          theme,
          source,
          height: radius,
          width: radius,
        ),
      ),
    );
