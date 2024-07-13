import 'package:education_app/common/usecase/usecase.dart';
import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/widgets/dropdown_menu/custom_dropdown_menu.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/constant/language.dart';
import 'package:education_app/domain/usecases/constant/fetch_languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<ApiResult<List<Language>>> {
  final FetchLanguages _fetchLanguages;
  LanguageCubit({required FetchLanguages fetchLanguages})
      : _fetchLanguages = fetchLanguages,
        super(const ApiResultLoading());

  Future<void> fetchLanguages() async {
    final res = await _fetchLanguages.call(NoPayload());
    res.fold(
      (l) => emit(ApiResultFailure(l.errorMessage)),
      (r) => emit(ApiResultSuccess(r)),
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
      child: BlocBuilder<LanguageCubit, ApiResult<List<Language>>>(
        builder: (context, state) {
          if (state is ApiResultLoading) {
            return Text("loading...");
          }
          if (state is ApiResultFailure) {
            return Text("error...");
          }
          if (state is ApiResultSuccess<List<Language>>) {
            return CustomDropdownMenu(
              label: 'Language of instruction',
              errorText: errorText,
              initialSelection: initialSelection,
              dropdownMenuEntries: _buildDropdownMenuItems(state),
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
