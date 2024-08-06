// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
// class ApiResponse<T> extends Equatable {
//   final T data;
//   final ApiError? error;

//   const ApiResponse({
//     required this.data,
//     this.error,
//   });

//   factory ApiResponse.fromJson(Map<String, dynamic> json) =>
//       _$ApiResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

//   @override
//   List<Object?> get props => [data, error];
// }

// @JsonSerializable()
// class ApiError extends Equatable {
//   final String message;
//   final int statusCode;
//   final String error;

//   const ApiError({
//     required this.message,
//     required this.statusCode,
//     required this.error,
//   });

//   factory ApiError.fromJson(Map<String, dynamic> json) =>
//       _$ApiErrorFromJson(json);

//   Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

//   @override
//   List<Object?> get props => [message, statusCode, error];
// }
