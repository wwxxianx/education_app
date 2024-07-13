import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/button/tab_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/presentation/manage_course_details/widgets/discount_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscountBottomSheet extends StatelessWidget {
  const DiscountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDraggableSheet(
      initialChildSize: 0.9,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.screenHorizontalPadding,
          right: Dimensions.screenHorizontalPadding,
          top: 10,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.84,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/icons/discount-filled.svg"),
                    6.kW,
                    const Text(
                      "Course Discount",
                      style: CustomFonts.titleMedium,
                    ),
                  ],
                ),
                centerTitle: false,
                leading: SizedBox(),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: CustomColors.slate50,
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 3.0,
                              offset: const Offset(0, 1),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 2.0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        labelColor: CustomColors.textBlack,
                        unselectedLabelColor: Colors.black54,
                        tabs: [
                          const TabItem(title: 'Created'),
                          const TabItem(title: 'NEW'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: const TabBarView(
                  children: [
                    Text('one'),
                    DiscountForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
