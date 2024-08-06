import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContinueLearningBottomSheet extends StatefulWidget {
  const ContinueLearningBottomSheet({super.key});

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

  void _handleClose() {
    print("Pressed");
    slideController.close();
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
                child: Image.asset(
                  "assets/images/course-sample-image.png",
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
                      "React Crash Course like a Pro React Crash Course like a Pro",
                      style: CustomFonts.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    2.kH,
                    Text(
                      "HTML - Introduction",
                      style: CustomFonts.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const HeroIcon(
                HeroIcons.play,
                style: HeroIconStyle.mini,
                size: 28,
                color: CustomColors.slate700,
              ),
              12.kW,
            ],
          ),
        ),
      ),
    );
  }
}
