import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/container/chip.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/common/widgets/container/tag.dart';
import 'package:education_app/common/widgets/course/course_card.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/presentation/course_details/course_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class CourseListTile extends StatelessWidget {
  final Course course;
  final bool showStatusChip;
  final VoidCallback? onPressed;
  const CourseListTile({
    super.key,
    required this.course,
    this.showStatusChip = false,
    this.onPressed,
  });

  Widget _buildStatusChip() {
    final statusEnum =
        CoursePublishStatus.values.byName(course.status ?? "PUBLISHED");
    final displayStatus = statusEnum.displayStatus;
    final chipStyle = statusEnum.chipStyle;

    return CustomChip(style: chipStyle, child: Text(displayStatus));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 18,
          left: 12,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CustomColors.containerBorderGrey,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showStatusChip) _buildStatusChip(),
            if (showStatusChip) 8.kH,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1.45 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: course.images.firstOrNull?.imageUrl ?? '',
                        errorWidget: (context, url, error) {
                          return Skeleton();
                        },
                      ),
                    ),
                  ),
                ),
                12.kW,
                Flexible(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              course.title,
                              maxLines: 2,
                              style: CustomFonts.labelMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Love button
                          IconButton(
                            onPressed: () {},
                            icon: HeroIcon(
                              HeroIcons.heart,
                            ),
                          ),
                        ],
                      ),
                      4.kH,
                      Text(
                        course.instructor.fullName,
                        style: CustomFonts.labelExtraSmall
                            .copyWith(color: CustomColors.textGrey),
                      ),
                      4.kH,
                      CustomTag.grey(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: Text(
                          course.level.level.capitalize(),
                          style: CustomFonts.bodyExtraSmall,
                        ),
                      ),
                      6.kH,
                      ReviewStar(
                        review: 4,
                      ),
                      6.kH,
                      Text(
                        "RM ${course.price}",
                        style: CustomFonts.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
