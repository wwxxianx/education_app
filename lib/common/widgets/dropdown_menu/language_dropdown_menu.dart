import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/dropdown_menu/custom_dropdown_menu.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/usecases/constant/fetch_languages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class LanguageState extends Equatable {
  final ApiResult<List<Language>> languagesResult;

  const LanguageState({
    required this.languagesResult,
  });

  factory LanguageState.initial() {
    return const LanguageState(
      languagesResult: ApiResultInitial(),
    );
  }

  LanguageState copyWith({
    ApiResult<List<Language>>? languagesResult,
  }) {
    return LanguageState(
      languagesResult: languagesResult ?? this.languagesResult,
    );
  }

  @override
  List<Object> get props => [languagesResult];
}

class LanguageCubit extends Cubit<LanguageState> {
  final FetchLanguages _fetchLanguages;
  LanguageCubit({required FetchLanguages fetchLanguages})
      : _fetchLanguages = fetchLanguages,
        super(LanguageState.initial());

  Future<void> fetchLanguages() async {
    final res = await _fetchLanguages.call(NoPayload());
    res.fold(
      (failure) => emit(state.copyWith(
          languagesResult: ApiResultFailure(failure.errorMessage))),
      (data) => emit(state.copyWith(languagesResult: ApiResultSuccess(data))),
    );
  }
}

class LanguagesDropdownMenu extends StatelessWidget {
  final void Function(String)? onSelected;
  final String? initialSelection;
  final String? errorText;
  const LanguagesDropdownMenu({
    super.key,
    this.onSelected,
    this.initialSelection,
    this.errorText,
  });

  List<DropdownMenuEntry<String>> _buildDropdownMenuItems(
      ApiResult<List<Language>> languages) {
    if (languages is ApiResultSuccess<List<Language>>) {
      return languages.data
          .map((e) =>
              DropdownMenuEntry(value: e.id, label: e.language.capitalize()))
          .toList();
    }
    return List.generate(
        1, (index) => const DropdownMenuEntry(value: "", label: "Loading..."));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(
        fetchLanguages: serviceLocator(),
      )..fetchLanguages(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          final languagesResult = state.languagesResult;
          if (languagesResult is ApiResultLoading) {
            return Text("loading...");
          }
          if (languagesResult is ApiResultFailure) {
            return Text("error...");
          }
          if (languagesResult is ApiResultSuccess<List<Language>>) {
            return CustomDropdownMenu(
              label: 'Language of instruction',
              errorText: errorText,
              initialSelection: initialSelection,
              dropdownMenuEntries: _buildDropdownMenuItems(languagesResult),
              onSelected: (languageId) {
                if (onSelected != null && languageId != null) {
                  onSelected!(languageId);
                }
              },
            );
          }
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
