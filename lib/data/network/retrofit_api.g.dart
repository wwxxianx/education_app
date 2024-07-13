// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??=
        'https://878e-202-184-8-138.ngrok-free.app/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<TokensResponse> signUp(SignUpPayload signUpPayload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(signUpPayload.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<TokensResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'auth/sign-up',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = TokensResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserModelWithAccessToken> signIn(LoginBEPayload payload) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(payload.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserModelWithAccessToken>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'auth/sign-in',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserModelWithAccessToken.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TokensResponse> getRefreshToken() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<TokensResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'auth/refresh',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = TokensResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserModel> updateUserProfile({
    String? fullName,
    File? profileImageFile,
    bool? isOnboardingCompleted,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (fullName != null) {
      _data.fields.add(MapEntry(
        'fullName',
        fullName,
      ));
    }
    if (profileImageFile != null) {
      _data.files.add(MapEntry(
        'profileImageFile',
        MultipartFile.fromFileSync(
          profileImageFile.path,
          filename: profileImageFile.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    if (isOnboardingCompleted != null) {
      _data.fields.add(MapEntry(
        'isOnboardingCompleted',
        isOnboardingCompleted.toString(),
      ));
    }
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserModel>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Language>> getLanguages() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<Language>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'languages',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => Language.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<CourseLevel>> getCourseLevels() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<CourseLevel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'course-levels',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => CourseLevel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<CourseCategory>> getCourseCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<CourseCategory>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'course-categories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => CourseCategory.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Course> createCourse({
    required String categoryId,
    required List<String> coursePartsTitle,
    required String description,
    required String levelId,
    required List<String> requirements,
    required String title,
    required List<String> topics,
    required List<String> subcategoryIds,
    required String languageId,
    required String sectionOneTitle,
    double? price,
    required List<File> courseImages,
    required List<File> courseResourceFiles,
    File? courseVideo,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'categoryId',
      categoryId,
    ));
    coursePartsTitle.forEach((i) {
      _data.fields.add(MapEntry('coursePartsTitle', i));
    });
    _data.fields.add(MapEntry(
      'description',
      description,
    ));
    _data.fields.add(MapEntry(
      'levelId',
      levelId,
    ));
    requirements.forEach((i) {
      _data.fields.add(MapEntry('requirements', i));
    });
    _data.fields.add(MapEntry(
      'title',
      title,
    ));
    topics.forEach((i) {
      _data.fields.add(MapEntry('topics', i));
    });
    subcategoryIds.forEach((i) {
      _data.fields.add(MapEntry('subcategoryIds', i));
    });
    _data.fields.add(MapEntry(
      'languageIds',
      languageId,
    ));
    _data.fields.add(MapEntry(
      'sectionOneTitle',
      sectionOneTitle,
    ));
    if (price != null) {
      _data.fields.add(MapEntry(
        'price',
        price.toString(),
      ));
    }
    _data.files.addAll(courseImages.map((i) => MapEntry(
        'courseImages',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    _data.files.addAll(courseResourceFiles.map((i) => MapEntry(
        'courseResourceFiles',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    if (courseVideo != null) {
      _data.files.add(MapEntry(
        'courseVideo',
        MultipartFile.fromFileSync(
          courseVideo.path,
          filename: courseVideo.path.split(Platform.pathSeparator).last,
        ),
      ));
    }
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Course>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'courses',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Course.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
