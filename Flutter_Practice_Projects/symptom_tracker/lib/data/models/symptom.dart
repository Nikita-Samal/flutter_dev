import 'package:freezed_annotation/freezed_annotation.dart';

part 'symptom.freezed.dart';
part 'symptom.g.dart';

@freezed
abstract class Symptom with _$Symptom {
  const factory Symptom({
    required String id,
    required String name,
    required DateTime recordedAt,
    String? notes,
    @Default(false) bool isSevere,
  }) = _Symptom;

  factory Symptom.fromJson(Map<String, dynamic> json) =>
      _$SymptomFromJson(json);
}