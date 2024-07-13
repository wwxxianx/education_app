import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/input/decorated_input_border.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CustomDropdownMenu extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialSelection;
  final String? label;
  final List<DropdownMenuEntry<String>> dropdownMenuEntries;
  final void Function(String?)? onSelected;
  final String? errorText;

  const CustomDropdownMenu({
    super.key,
    this.controller,
    this.label,
    required this.dropdownMenuEntries,
    this.onSelected,
    this.initialSelection,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label!, style: CustomFonts.labelSmall),
        if (label != null && label!.isNotEmpty) 4.kH,
        DropdownMenu(
          errorText: errorText,
          initialSelection: initialSelection,
          menuHeight: 280,
          width: MediaQuery.of(context).size.width -
              (Dimensions.screenHorizontalPadding * 2),
          controller: controller,
          requestFocusOnTap: true,
          trailingIcon: const HeroIcon(
            HeroIcons.chevronDown,
            size: 16,
          ),
          selectedTrailingIcon: const HeroIcon(
            HeroIcons.chevronUp,
            size: 16,
          ),
          menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            surfaceTintColor: MaterialStateProperty.all(Colors.white),
          ),
          inputDecorationTheme: InputDecorationTheme(
            constraints: BoxConstraints(
              maxHeight: errorText == null ? 48 : 72,
              // minWidth: 400,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 0.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            activeIndicatorBorder: const BorderSide(color: Colors.red),
            focusedBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: CustomColors.primaryBlue, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadow: BoxShadow(
                blurRadius: 4.0,
                offset: const Offset(0, 0),
                color: CustomColors.primaryBlue.withOpacity(0.4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColors.inputBorder,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          dropdownMenuEntries: dropdownMenuEntries,
          onSelected: onSelected,
        ),
      ],
    );
  }
}
