import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/utils/common_widgets/shimmer_effect.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationItem extends StatefulWidget {
  String? notificationImage;
  String? notificationMessage;
  DateTime? notificationTimestamp;
  VoidCallback? onPressed;
  bool? seen;
  bool? isImageAvailable = true;

  NotificationItem(
      {super.key,
      this.notificationImage,
      this.notificationMessage,
      this.notificationTimestamp,
      this.onPressed,
      this.seen,
      this.isImageAvailable});
  @override
  NotificationItemState createState() => NotificationItemState();
}

class NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 16,
        ),
        child: Row(
          children: <Widget>[
            widget.isImageAvailable!
                ? CachedNetworkImage(
                    imageUrl: widget.notificationImage ?? "",
                    placeholder: (context, url) => const Center(
                      child: ShimmerEffect(
                        height: 48,
                        width: 48,
                        isCircular: true,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: ShimmerEffect(
                        height: 48,
                        width: 48,
                        isCircular: true,
                      ),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.notificationMessage!,
                          style: FontStyles.montserratRegular14().copyWith(
                              fontSize: 14.0,
                              color: AppColors.textPrimary,
                              height: 2.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                          ),
                          child: Text(
                            "20 mints ago",
                            style: FontStyles.montserratRegular14().copyWith(
                                fontSize: 14.0,
                                color: AppColors.textSecondary,
                                height: 2.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      transform: Matrix4.translationValues(0.0, 12.0, 0.0),
                      child: Container(
                        height: 0.5,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
