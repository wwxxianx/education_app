import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyIllustration extends StatelessWidget {
  final String? title;
  const EmptyIllustration({super.key, this.title,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
        child: Column(
          children: [
            SvgPicture.asset("assets/images/empty-illustration.svg"),
            20.kH,
            Text(
              title ?? "Empty",
              style: CustomFonts.labelLarge,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
