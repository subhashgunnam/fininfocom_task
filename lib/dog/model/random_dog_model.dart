
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'random_dog_model.freezed.dart';
part 'random_dog_model.g.dart';
@freezed
class DogModel with _$DogModel {
  const factory DogModel({
    required String? message,
    required String? status
  }) = _DogModel;
  //
  factory DogModel.fromJson(Map<String, Object?> json)
  => _$DogModelFromJson(json);
}