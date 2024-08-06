import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/widgets/button/toggle_button.dart';
import 'package:education_app/common/widgets/container/skeleton.dart';
import 'package:education_app/common/widgets/dropdown_menu/language_dropdown_menu.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageToggleList extends StatelessWidget {
  final bool isSmall;
  final List<String> selectedLanguageIds;
  final void Function(Language language) onPressed;

  const LanguageToggleList({
    super.key,
    required this.onPressed,
    this.selectedLanguageIds = const [],
    this.isSmall = false,
  });

  List<Widget> _buildContent(ApiResult<List<Language>> languages) {
    if (languages is ApiResultSuccess<List<Language>>) {
      return languages.data.map(
        (category) {
          return CustomToggleButton(
            padding: isSmall
                ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0)
                : null,
            isSelected: selectedLanguageIds.contains(category.id),
            onTap: () {
              onPressed(category);
            },
            child: Text(
              category.language,
              style: isSmall
                  ? CustomFonts.labelExtraSmall
                  : CustomFonts.labelMedium,
            ),
          );
        },
      ).toList();
    }
    return List.generate(5, (index) {
      return const Skeleton(
        radius: 100,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final languagesResult = state.languagesResult;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          direction: Axis.horizontal,
          children: _buildContent(languagesResult),
        );
      },
    );
  }
}
