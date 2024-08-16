import 'dart:io';

import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/data/network/payload/course/course_faq.dart';
import 'package:education_app/data/network/payload/course/course_payload.dart';
import 'package:education_app/data/network/payload/course/course_section_payload.dart';
import 'package:education_app/data/network/payload/voucher/voucher_payload.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/voucher/voucher.dart';
import 'package:education_app/domain/usecases/course/craete_course_voucher.dart';
import 'package:education_app/domain/usecases/course/create_course_part.dart';
import 'package:education_app/domain/usecases/course/create_course_section.dart';
import 'package:education_app/domain/usecases/course/fetch_course.dart';
import 'package:education_app/domain/usecases/course/fetch_course_faq.dart';
import 'package:education_app/domain/usecases/course/fetch_course_vouchers.dart';
import 'package:education_app/domain/usecases/course/update_course.dart';
import 'package:education_app/domain/usecases/course/update_course_faq.dart';
import 'package:education_app/domain/usecases/course/update_course_section.dart';
import 'package:education_app/state_management/create_course/create_course_state.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_event.dart';
import 'package:education_app/state_management/manage_course_details/manage_course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class ManageCourseDetailsBloc
    extends Bloc<ManageCourseDetailsEvent, ManageCourseDetailsState> {
  final FetchCourse _fetchCourse;
  final UpdateCourse _updateCourse;
  final FetchCourseFAQ _fetchCourseFAQ;
  final UpdateCourseFAQ _updateCourseFAQ;
  final FetchCourseVouchers _fetchCourseVouchers;
  final CreateCourseVoucher _createCourseVoucher;
  final UpdateCourseSection _updateCourseSection;
  final CreateCoursePart _createCoursePart;
  final CreateCourseSection _createCourseSection;

  ManageCourseDetailsBloc({
    required FetchCourse fetchCourse,
    required UpdateCourse updateCourse,
    required FetchCourseFAQ fetchCourseFAQ,
    required UpdateCourseFAQ updateCourseFAQ,
    required FetchCourseVouchers fetchCourseVouchers,
    required CreateCourseVoucher createCourseVoucher,
    required UpdateCourseSection updateCourseSection,
    required CreateCoursePart createCoursePart,
    required CreateCourseSection createCourseSection,
  })  : _fetchCourse = fetchCourse,
        _updateCourse = updateCourse,
        _fetchCourseFAQ = fetchCourseFAQ,
        _updateCourseFAQ = updateCourseFAQ,
        _fetchCourseVouchers = fetchCourseVouchers,
        _createCourseVoucher = createCourseVoucher,
        _updateCourseSection = updateCourseSection,
        _createCoursePart = createCoursePart,
        _createCourseSection = createCourseSection,
        super(const ManageCourseDetailsState.initial()) {
    on<ManageCourseDetailsEvent>(_onEvent);
  }

  Future<void> _onEvent(
    ManageCourseDetailsEvent event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    return switch (event) {
      final OnTabIndexChanged e => _onTabIndexChanged(e, emit),
      final OnFetchCourse e => _onFetchCourse(e, emit),
      final OnUpdateCourseStatus e => _onUpdateCourseStatus(e, emit),
      final OnFetchCourseFAQ e => _onFetchCourseFAQ(e, emit),
      final OnAddFAQ e => _onAddFAQ(e, emit),
      final OnFAQQuestionChanged e => _onFAQQuestionChanged(e, emit),
      final OnFAQAnswerChanged e => _onFAQAnswerChanged(e, emit),
      final OnUpdateCourseFAQ e => _onUpdateCourseFAQ(e, emit),
      final OnCreateCourseVoucher e => _onCreateCourseVoucher(e, emit),
      final OnFetchCourseVouchers e => _onFetchCourseVouchers(e, emit),
      final OnDiscountChanged e => _onDiscountChanged(e, emit),
      final OnVoucherTitleChanged e => _onVoucherTitleChanged(e, emit),
      final OnVoucherExpirationDateChanged e =>
        _onVoucherExpirationDateChanged(e, emit),
      final OnVoucherStockChanged e => _onVoucherStockChanged(e, emit),
      final OnSelectCourseCategory e => _onSelectCourseCategory(e, emit),
      final OnSelectCourseSubcategory e => _onSelectCourseSubcategory(e, emit),
      final OnSelectLevel e => _onSelectLevel(e, emit),
      final OnTitleChanged e => _onTitleChanged(e, emit),
      final OnPriceChanged e => _onPriceChanged(e, emit),
      final OnUpdateCourse e => _onUpdateCourse(e, emit),
      final OnUpdateCourseSection e => _onUpdateCourseSection(e, emit),
      final OnCreateCoursePart e => _onCreateCoursePart(e, emit),
      final OnCreateCourseSection e => _onCreateCourseSection(e, emit),
      final OnAddNewPart e => _onAddNewPart(e, emit),
      final OnRemovePart e => _onRemovePart(e, emit),
      final OnPartTitleChanged e => _onPartTitleChanged(e, emit),
      final OnPartFileChanged e => _onPartFileChanged(e, emit),
      final OnSectionTitleChanged e =>
        emit(state.copyWith(sectionOneTitle: e.value)),
    };
  }

  void _onAddNewPart(
    OnAddNewPart event,
    Emitter emit,
  ) {
    emit(state
        .copyWith(partFields: [...state.partFields, const CoursePartField()]));
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

  Future<void> _onCreateCoursePart(
    OnCreateCoursePart event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(submitCoursePartResult: const ApiResultLoading()));

    final res = await _createCoursePart.call(event.payload);
    res.fold(
      (failure) => emit(state.copyWith(
          submitCoursePartResult: ApiResultFailure(failure.errorMessage))),
      (coursePart) {
        _updateCoursePartFromCreate(coursePart, emit);
        emit(state.copyWith(
            submitCoursePartResult: ApiResultSuccess(coursePart)));
        event.onSuccess(coursePart);
      },
    );
  }

  Future<void> _onCreateCourseSection(
    OnCreateCourseSection event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(submitCourseSectionResult: const ApiResultLoading()));
    final payload = CreateCourseSectionPayload(
      courseId: event.courseId,
      title: state.sectionOneTitle ?? "",
      coursePartsTitle: state.partFields.map((e) => e.title ?? "").toList(),
      resourceFiles:
          state.partFields.map((e) => e.resourceFile ?? File("path")).toList(),
    );
    final res = await _createCourseSection.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          submitCourseSectionResult: ApiResultFailure(failure.errorMessage))),
      (courseSection) {
        _updateCourseSectionFromCreate(courseSection, emit);
        emit(state.copyWith(
            submitCourseSectionResult: ApiResultSuccess(courseSection)));
        event.onSuccess(courseSection);
      },
    );
  }

  void _updateCoursePartFromUpdate(CoursePart coursePart, Emitter emit) {
    final courseResult = state.courseResult;
    if (courseResult is ApiResultSuccess<Course>) {
      emit(state.copyWith(
          courseResult: ApiResultSuccess(courseResult.data.copyWith(
              sections: courseResult.data.sections.map((section) {
        return section.copyWith(
            parts: section.parts.map((part) {
          if (part.id == coursePart.id) {
            return coursePart;
          }
          return part;
        }).toList());
      }).toList()))));
    }
  }

  void _updateCoursePartFromCreate(CoursePart coursePart, Emitter emit) {
    final courseResult = state.courseResult;
    if (courseResult is ApiResultSuccess<Course>) {
      emit(state.copyWith(
        courseResult: ApiResultSuccess(
          courseResult.data.copyWith(
            sections: courseResult.data.sections.map((section) {
              if (section.id == coursePart.courseSectionId) {
                return section.copyWith(parts: [...section.parts, coursePart]);
              }
              return section;
            }).toList(),
          ),
        ),
      ));
    }
  }

  Future<void> _onUpdateCourseSection(
    OnUpdateCourseSection event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(submitCourseSectionResult: const ApiResultLoading()));

    final res = await _updateCourseSection(event.payload);
    res.fold((l) => null, (r) {
      _updateCourseSectionFromUpdate(r, emit);
      emit(state.copyWith(submitCourseSectionResult: ApiResultSuccess(r)));
    });
  }

  void _updateCourseSectionFromUpdate(
    CourseSection updatedCourseSection,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    final courseResult = state.courseResult;
    if (courseResult is ApiResultSuccess<Course>) {
      emit(state.copyWith(
          courseResult: ApiResultSuccess(courseResult.data.copyWith(
              sections: courseResult.data.sections.map((section) {
        if (section.id == updatedCourseSection.id) {
          return section.copyWith(title: updatedCourseSection.title);
        }
        return section;
      }).toList()))));
    }
  }

  void _updateCourseSectionFromCreate(
    CourseSection updatedCourseSection,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    final courseResult = state.courseResult;
    if (courseResult is ApiResultSuccess<Course>) {
      emit(state.copyWith(
        courseResult: ApiResultSuccess(
          courseResult.data.copyWith(
            sections: [
              ...courseResult.data.sections,
              updatedCourseSection,
            ],
          ),
        ),
      ));
    }
  }

  void _updateCourseToLatestState(
    Course updatedCourse,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    final courseResult = state.courseResult;
    if (courseResult is ApiResultSuccess<Course>) {
      emit(state.copyWith(
          courseResult: ApiResultSuccess(courseResult.data.copyWith(
        status: updatedCourse.status,
        category: updatedCourse.category,
        subcategories: updatedCourse.subcategories,
        level: updatedCourse.level,
        description: updatedCourse.description,
        language: updatedCourse.language,
        price: updatedCourse.price,
        requirements: updatedCourse.requirements,
        title: updatedCourse.title,
        topics: updatedCourse.topics,
      ))));
    }
  }

  Future<void> _onUpdateCourse(
    OnUpdateCourse event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(updateCourseResult: const ApiResultLoading()));

    final payload = event.payload ??
        UpdateCoursePayload(
          courseId: event.courseId,
          categoryId: state.selectedCategoryId,
          languageId: state.selectedLevelId,
          subcategoryIds: state.selectedSubcategoryIds,
          price: state.priceText != null
              ? int.parse(state.priceText!) * 100
              : null,
          title: state.titleText,
        );
    print("requirements: ${payload.requirements}");
    final res = await _updateCourse.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          updateCourseFAQResult: ApiResultFailure(failure.errorMessage))),
      (updatedCourse) {
        _updateCourseToLatestState(updatedCourse, emit);
        emit(state.copyWith(updateCourseResult: const ApiResultInitial()));
        event.onSuccess?.call();
      },
    );
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

  void _onPriceChanged(
    OnPriceChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(priceText: event.value));
  }

  void _onDiscountChanged(
    OnDiscountChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(discountText: event.value));
  }

  void _onVoucherTitleChanged(
    OnVoucherTitleChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(titleText: event.value));
  }

  void _onVoucherExpirationDateChanged(
    OnVoucherExpirationDateChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(voucherExpirationDate: event.value));
  }

  void _onVoucherStockChanged(
    OnVoucherStockChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(voucherStockText: event.value));
  }

  Future<void> _onCreateCourseVoucher(
    OnCreateCourseVoucher event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(createVoucherResult: const ApiResultLoading()));

    final payload = CreateVoucherPayload(
      title: state.voucherTitleText ?? "",
      courseId: event.courseId,
      afterDiscountValue: int.parse(state.discountText!),
      expiredAt: state.voucherExpirationDate,
      stock: state.voucherStockText != null
          ? int.parse(state.voucherStockText!)
          : null,
    );
    final res = await _createCourseVoucher.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          createVoucherResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        emit(state.copyWith(createVoucherResult: ApiResultSuccess(data)));
        _updateCourseVoucherList(data, emit);
        event.onSuccess();
      },
    );
  }

  _updateCourseVoucherList(
    CourseVoucher newVoucher,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    final courseVoucherResult = state.courseVoucherResult;
    if (courseVoucherResult is ApiResultSuccess<List<CourseVoucher>>) {
      final courseVouchers = courseVoucherResult.data;
      final newVoucherList = [newVoucher, ...courseVouchers];
      emit(
        state.copyWith(
          courseVoucherResult: ApiResultSuccess(newVoucherList),
        ),
      );
    }
  }

  Future<void> _onFetchCourseVouchers(
    OnFetchCourseVouchers event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(courseVoucherResult: const ApiResultLoading()));

    final res = await _fetchCourseVouchers.call(event.courseId);
    res.fold(
      (failure) => emit(state.copyWith(
          courseVoucherResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        emit(state.copyWith(courseVoucherResult: ApiResultSuccess(data)));
      },
    );
  }

  Future<void> _onUpdateCourseFAQ(
    OnUpdateCourseFAQ event,
    Emitter<ManageCourseDetailsState> emit,
  ) async {
    emit(state.copyWith(updateCourseFAQResult: const ApiResultLoading()));

    final payload = UpdateCourseFAQPayload(
        courseId: event.courseId, faqList: state.courseFAQList);
    final res = await _updateCourseFAQ.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          updateCourseFAQResult: ApiResultFailure(failure.errorMessage))),
      (data) {
        emit(state.copyWith(updateCourseFAQResult: ApiResultSuccess(data)));
        event.onSuccess();
      },
    );
  }

  void _onFAQQuestionChanged(
    OnFAQQuestionChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(
      courseFAQList: state.courseFAQList
          .mapWithIndex((e, index) =>
              index == event.index ? e.copyWith(question: event.value) : e)
          .toList(),
    ));
  }

  void _onFAQAnswerChanged(
    OnFAQAnswerChanged event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(
      courseFAQList: state.courseFAQList
          .mapWithIndex((e, index) =>
              index == event.index ? e.copyWith(answer: event.value) : e)
          .toList(),
    ));
  }

  void _onAddFAQ(
    OnAddFAQ event,
    Emitter<ManageCourseDetailsState> emit,
  ) {
    emit(state.copyWith(courseFAQList: [
      ...state.courseFAQList,
      CourseFAQItem(id: '', question: '', answer: ''),
    ]));
  }

  Future<void> _onUpdateCourseStatus(
    OnUpdateCourseStatus event,
    Emitter emit,
  ) async {
    emit(state.copyWith(updateCourseResult: const ApiResultLoading()));
    final payload = UpdateCoursePayload(
      courseId: event.courseId,
      status: event.status,
    );
    final res = await _updateCourse.call(payload);
    res.fold(
      (failure) => emit(state.copyWith(
          updateCourseResult: ApiResultFailure(failure.errorMessage))),
      (course) {
        final courseResult = state.courseResult;
        if (courseResult is ApiResultSuccess<Course>) {
          // update current course state
          emit(state.copyWith(
              courseResult: ApiResultSuccess(
                  courseResult.data.copyWith(status: course.status))));
        }
        emit(state.copyWith(
          updateCourseResult: ApiResultSuccess(course),
        ));
        event.onSuccess();
      },
    );
  }

  Future<void> _onFetchCourseFAQ(
    OnFetchCourseFAQ event,
    Emitter emit,
  ) async {
    emit(state.copyWith(courseFAQResult: const ApiResultLoading()));
    final res = await _fetchCourseFAQ.call(event.courseId);
    res.fold(
      (failure) => emit(state.copyWith(
          courseFAQResult: ApiResultFailure(failure.errorMessage))),
      (faq) => emit(
        state.copyWith(
          courseFAQResult: ApiResultSuccess(faq),
          courseFAQList: faq.map((e) => e.toCourseFAQItem()).toList(),
        ),
      ),
    );
  }

  Future<void> _onFetchCourse(
    OnFetchCourse event,
    Emitter emit,
  ) async {
    final res = await _fetchCourse.call(event.courseId);
    res.fold(
      (failure) => emit(
          state.copyWith(courseResult: ApiResultFailure(failure.errorMessage))),
      (course) {
        emit(state.copyWith(
          courseResult: ApiResultSuccess(course),
          titleText: course.title,
          selectedCategoryId: course.category.id,
          priceText: (course.price / 100).toStringAsFixed(0),
          selectedLevelId: course.level.id,
          selectedSubcategoryIds:
              course.subcategories.map((category) => category.id).toList(),
        ));
      },
    );
  }

  void _onTabIndexChanged(
    OnTabIndexChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(currentTabIndex: event.index));
  }
}
