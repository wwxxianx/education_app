import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/domain/model/user/course_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class ContinueLearningBottomSheet extends StatefulWidget {
  final CourseProgress courseProgress;
  const ContinueLearningBottomSheet({
    super.key,
    required this.courseProgress,
  });

  @override
  State<ContinueLearningBottomSheet> createState() =>
      _ContinueLearningBottomSheetState();
}

class _ContinueLearningBottomSheetState
    extends State<ContinueLearningBottomSheet>
    with SingleTickerProviderStateMixin {
  late final SlidableController slideController;

  @override
  void initState() {
    super.initState();
    slideController = SlidableController(this);
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  void _navigateToLearningDetails() {
    context.push("/my-learning/${widget.courseProgress.course.id}",
        extra: widget.courseProgress.coursePart);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.white,
            icon: Icons.chevron_left_rounded,
            label: "Slide to remove",
          )
        ],
      ),
      direction: Axis.horizontal,
      enabled: true,
      closeOnScroll: true,
      controller: slideController,
      key: const ValueKey("1"),
      child: IntrinsicHeight(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 90),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              horizontal: BorderSide(color: CustomColors.containerBorderSlate),
            ),
          ),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: CachedNetworkImage(
                  imageUrl: widget.courseProgress.course.thumbnailUrl ?? "",
                  errorWidget: (context, url, error) {
                    return const Skeleton();
                  },
                  fit: BoxFit.cover,
                ),
              ),
              8.kW,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Continue your learning:",
                      style: CustomFonts.bodyExtraSmall.copyWith(
                        color: CustomColors.textGrey,
                      ),
                    ),
                    4.kH,
                    Text(
                      widget.courseProgress.course.title,
                      style: CustomFonts.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    2.kH,
                    Text(
                      widget.courseProgress.coursePart.title,
                      style: CustomFonts.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _navigateToLearningDetails,
                child: const HeroIcon(
                  HeroIcons.play,
                  style: HeroIconStyle.mini,
                  size: 28,
                  color: CustomColors.slate700,
                ),
              ),
              12.kW,
            ],
          ),
        ),
      ),
    );
  }
}
