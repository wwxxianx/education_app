import 'package:education_app/common/utils/extensions/string.dart';
import 'package:education_app/common/utils/input_validator.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/create_course_payload.dart';
import 'package:education_app/domain/usecases/course/create_course.dart';
import 'package:education_app/state_management/create_course/create_course_event.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState>
    with InputValidator {
  final CreateCourse _createCourse;

  CreateCourseBloc({
    required CreateCourse createCourse,
  })  : _createCourse = createCourse,
        super(const CreateCourseState.initial()) {
    on<CreateCourseEvent>(_onEvent);
  }

  Future<void> _onEvent(CreateCourseEvent event, Emitter emit) async {
    return switch (event) {
      final OnSelectCourseCategory e => _onSelectCourseCategory(e, emit),
      final OnSelectCourseSubcategory e => _onSelectCourseSubcategory(e, emit),
      final OnSelectLevel e => _onSelectLevel(e, emit),
      final OnTitleChanged e => _onTitleChanged(e, emit),
      final OnDescriptionChanged e => _onDescriptionChanged(e, emit),
      final OnSyncTopics e => _onSyncTopics(e, emit),
      final OnSyncRequirements e => _onSyncRequirements(e, emit),
      final OnAddTopic e => _onAddTopic(e, emit),
      final OnRemoveTopic e => _onRemoveTopic(e, emit),
      final OnReorderTopic e => _onReorderTopic(e, emit),
      final OnSelectLanguage e => _onSelectLanguage(e, emit),
      final OnPriceChanged e => _onPriceChanged(e, emit),
      final ValidateRelationData e => _validateStepOne(e, emit),
      final ValidateDetailData e => _validateStepTwo(e, emit),
      final ValidateMediaData e => _validateMediaData(e, emit),
      final OnAddNewPart e => _onAddNewPart(e, emit),
      final OnRemovePart e => _onRemovePart(e, emit),
      final OnSectionTitleChanged e => _onSectionTitleChanged(e, emit),
      final OnPartTitleChanged e => _onPartTitleChanged(e, emit),
      final OnPartFileChanged e => _onPartFileChanged(e, emit),
      final OnCreateCourse e => _onCreateCourse(e, emit),
      final OnAddCourseImageFile e => _onAddCourseImageFile(e, emit),
      final OnAddCourseVideoFile e => _onAddCourseVideoFile(e, emit),
      final ValidateOverviewData e => _validateOverviewData(e, emit),
      final ValidateCurriculumData e => _validateCurriculumData(e, emit),
    };
  }

  Future<void> _onCreateCourse(
    OnCreateCourse event,
    Emitter emit,
  ) async {
    emit(state.copyWith(createCourseResult: const ApiResultLoading()));
    final payload = CreateCoursePayload(
      categoryId: state.selectedCategoryId!,
      coursePartsTitle: state.partFields.map((part) {
        final title = part.title ?? "";
        return title;
      }).toList(),
      description: state.descriptionText ?? "",
      levelId: state.selectedLevelId ?? "",
      requirements: state.requirements,
      title: state.titleText ?? "",
      topics: state.topics,
      subcategoryIds: state.selectedSubcategoryIds,
      languageId: state.selectedLanguageId ?? "",
      sectionOneTitle: state.sectionOneTitle ?? "",
      courseImages: state.courseImageFiles,
      courseVideo: state.courseVideoFile,
      courseResourceFiles: state.partFields.map((part) {
        final file = part.resourceFile!;
        return file;
      }).toList(),
      price: state.priceText.isNotNullAndEmpty ? double.parse(state.priceText!) : null,
    );
    final res = await _createCourse.call(payload);
    res.fold(
      (failure) => emit(
          state.copyWith(createCourseResult: ApiResultFailure(failure.errorMessage))),
      (course) {
        emit(state.copyWith(createCourseResult: ApiResultSuccess(course)));
        event.onSuccess();
      },
    );
  }

  void _onAddCourseImageFile(
    OnAddCourseImageFile event,
    Emitter emit,
  ) {
    emit(state.copyWith(courseImageFiles: event.files));
  }

  void _onAddCourseVideoFile(
    OnAddCourseVideoFile event,
    Emitter emit,
  ) {
    emit(state.copyWith(courseVideoFile: event.file));
  }

  void _onSectionTitleChanged(
    OnSectionTitleChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(sectionOneTitle: event.value));
  }

  void _onPartTitleChanged(
    OnPartTitleChanged event,
    Emitter emit,
  ) {
    var partFields = state.partFields;
    partFields = partFields.mapWithIndex((item, index) {
      if (index == event.index) {
        return item.copyWith(title: event.title);
      }
      return item;
    }).toList();
    emit(state.copyWith(partFields: partFields));
  }

  void _onPartFileChanged(
    OnPartFileChanged event,
    Emitter emit,
  ) {
    var partFields = state.partFields;
    partFields = partFields.mapWithIndex((item, index) {
      if (index == event.index) {
        return item.copyWith(resourceFile: event.file);
      }
      return item;
    }).toList();
    emit(state.copyWith(partFields: partFields));
  }

  void _onRemovePart(
    OnRemovePart event,
    Emitter emit,
  ) {
    final partFields = state.partFields
        .filterWithIndex(
          (t, index) => index != event.index,
        )
        .toList();
    emit(state.copyWith(partFields: partFields));
  }

  void _onAddNewPart(
    OnAddNewPart event,
    Emitter emit,
  ) {
    emit(state.copyWith(partFields: [...state.partFields, CoursePartField()]));
  }

  void _onPriceChanged(
    OnPriceChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(priceText: event.value));
  }

  void _onSyncTopics(
    OnSyncTopics event,
    Emitter emit,
  ) {
    emit(state.copyWith(topics: event.topics));
  }

  void _onSyncRequirements(
    OnSyncRequirements event,
    Emitter emit,
  ) {
    emit(state.copyWith(requirements: event.requirements));
  }

  void _onAddTopic(
    OnAddTopic event,
    Emitter emit,
  ) {
    emit(state.copyWith(topics: [...state.topics, '']));
  }

  void _onRemoveTopic(
    OnRemoveTopic event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(
        topics: state.topics
            .filterWithIndex((t, index) => index != event.index)
            .toList(),
      ),
    );
  }

  void _onReorderTopic(
    OnReorderTopic event,
    Emitter emit,
  ) {
    var newIndex = event.newIndex;
    if (event.oldIndex < event.newIndex) {
      newIndex--;
    }
    final newTopics = List<String>.from(state.topics);
    final topicItem = newTopics.removeAt(event.oldIndex);
    newTopics.insert(newIndex, topicItem);

    // Emit the new state with the updated topics
    emit(state.copyWith(topics: newTopics));
  }

  void _onSelectLanguage(
    OnSelectLanguage event,
    Emitter emit,
  ) {
    emit(state.copyWith(selectedLanguageId: event.languageId));
  }

  void _onSelectCourseCategory(
    OnSelectCourseCategory event,
    Emitter emit,
  ) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
  }

  void _onSelectCourseSubcategory(
    OnSelectCourseSubcategory event,
    Emitter emit,
  ) {
    List<String> updatedSubcategoryIds;
    if (state.selectedSubcategoryIds.contains(event.categoryId)) {
      updatedSubcategoryIds = state.selectedSubcategoryIds
          .filter((id) => id != event.categoryId)
          .toList();
    } else {
      updatedSubcategoryIds = [
        ...state.selectedSubcategoryIds,
        event.categoryId
      ];
    }
    emit(state.copyWith(selectedSubcategoryIds: updatedSubcategoryIds));
  }

  void _onSelectLevel(
    OnSelectLevel event,
    Emitter emit,
  ) {
    emit(state.copyWith(selectedLevelId: event.levelId));
  }

  void _onTitleChanged(
    OnTitleChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(titleText: event.value));
  }

  void _onDescriptionChanged(
    OnDescriptionChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(descriptionText: event.value));
  }

  void _validateStepOne(
    ValidateRelationData event,
    Emitter emit,
  ) {
    if (state.selectedCategoryId == null) {
      emit(state.copyWith(categoryError: 'Course category is required'));
      return;
    }
    if (state.selectedSubcategoryIds.isEmpty) {
      emit(state.copyWith(subcategoryError: 'Course subcategory is required'));
      return;
    }
    emit(state.copyWith(
      categoryError: null,
      subcategoryError: null,
    ));
    event.onSuccess();
  }

  void _validateStepTwo(
    ValidateDetailData event,
    Emitter emit,
  ) {
    final titleResult = validateStringWithMinMaxLength(
      title: 'Course title',
      value: state.titleText,
      minLength: 10,
      maxLength: 200,
    );
    final descriptionResult = validateStringWithMinMaxLength(
      title: 'Course content',
      value: state.descriptionError,
      minLength: 10,
      maxLength: 2000,
    );
    final languageResult = state.selectedLanguageId == null
        ? const InputValidationResult.success()
        : const InputValidationResult.fail('Teaching language is required');
    final levelResult = state.selectedLevelId == null
        ? const InputValidationResult.success()
        : const InputValidationResult.fail('Level is required');
    final hasError = List.of(<InputValidationResult>[
      titleResult,
      descriptionResult,
      languageResult,
      levelResult,
    ]).any((element) => !element.successful);

    if (hasError) {
      emit(state.copyWith(
        titleError: titleResult.errorMessage,
        descriptionError: descriptionResult.errorMessage,
        languageError: languageResult.errorMessage,
        levelError: levelResult.errorMessage,
      ));
      return;
    }
    emit(state.copyWith(
      titleError: null,
      descriptionError: null,
      languageError: null,
      levelError: null,
    ));
    event.onSuccess();
  }

  void _validateMediaData(
    ValidateMediaData event,
    Emitter emit,
  ) {
    if (state.courseImageFiles.isEmpty) {
      emit(state.copyWith(imageError: "Image is required"));
      return;
    }
    emit(state.copyWith(
      imageError: null,
    ));
    event.onSuccess();
  }

  void _validateCurriculumData(
    ValidateCurriculumData event,
    Emitter emit,
  ) {
    final sectionTitleResult =
        state.sectionOneTitle == null || state.sectionOneTitle?.isEmpty == true
            ? const InputValidationResult.fail('Section title is required')
            : const InputValidationResult.success();
    
    event.onSuccess();
  }

  void _validateOverviewData(
    ValidateOverviewData event,
    Emitter emit,
  ) {
    event.onSuccess();
  }
}
