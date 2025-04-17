// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'failure.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.error(Failure failure) = Error<T>;
}
