import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/avatar/avatar.dart';
import 'package:education_app/domain/model/notification/notification.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NotificationItem extends StatelessWidget {
  final Border? border;
  final NotificationModel notification;
  const NotificationItem({
    super.key,
    required this.notification,
    this.border,
  });

  void _handlePressed(BuildContext context) {
    context
        .read<AppUserCubit>()
        .toggleReadNotification(notificationId: notification.id);
    switch (notification.notificationType) {
      case NotificationType.COURSE_ENROLLED:
      case NotificationType.COURSE_VOUCHER:
      case NotificationType.COURSE_UPDATE:
        context.push('/course-details/${notification.entityId}');
    }
  }

  Widget _buildFooter() {
    // final notificationType = NotificationType.values.byName(notification.type);
    switch (notification.notificationType) {
      case NotificationType.COURSE_ENROLLED:
        return Text(
          notification.createdAt.toTimeAgo(),
          style: CustomFonts.labelExtraSmall.copyWith(
            color: CustomColors.textGrey,
          ),
        );
      case NotificationType.COURSE_VOUCHER:
      case NotificationType.COURSE_UPDATE:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Avatar(
                  imageUrl: notification.course?.thumbnailUrl,
                  size: 45,
                  border: Border.all(color: Colors.white),
                ),
                Positioned(
                  right: -10,
                  child: Avatar(
                    imageUrl: notification.actor?.profileImageUrl,
                    size: 26,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            16.kW,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notification.actor != null)
                  Text(
                    "Posted by ${notification.actor!.fullName}",
                    style: CustomFonts.labelExtraSmall
                        .copyWith(color: CustomColors.textGrey),
                  ),
                Text(
                  notification.createdAt.toTimeAgo(),
                  style: CustomFonts.labelExtraSmall
                      .copyWith(color: CustomColors.textGrey),
                ),
              ],
            ),
          ],
        );
      default:
        return Text('nothing');
    }
  }

  Widget _buildHeader() {
    switch (notification.notificationType) {
      case NotificationType.COURSE_VOUCHER:
        return Row(
          children: [
            SvgPicture.asset("assets/icons/ticket.svg"),
            6.kW,
            const Text(
              "NEW Voucher!",
              style: CustomFonts.labelMedium,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handlePressed(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.screenHorizontalPadding,
          vertical: 14.0,
        ),
        decoration: BoxDecoration(
          border: border ??
              const Border(
                bottom: BorderSide(
                  color: CustomColors.containerBorderGrey,
                ),
              ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (notification.notificationType ==
                NotificationType.COURSE_VOUCHER)
              8.kH,
            Row(
              children: [
                Expanded(
                  child: Text(
                    notification.title,
                    style: CustomFonts.labelMedium,
                  ),
                ),
                if (!notification.isRead) 12.kW,
                if (!notification.isRead)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColors.primaryBlue,
                    ),
                  ),
              ],
            ),
            2.kH,
            if (notification.description != null &&
                notification.description!.isNotEmpty)
              Text(
                notification.description!,
                style: CustomFonts.bodySmall,
              ),
            8.kH,
            _buildFooter(),
          ],
        ),
      ),
    );
  }
}
