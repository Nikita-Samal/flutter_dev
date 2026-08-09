// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Symptom _$SymptomFromJson(Map<String, dynamic> json) => _Symptom(
  id: json['id'] as String,
  name: json['name'] as String,
  recordedAt: DateTime.parse(json['recordedAt'] as String),
  notes: json['notes'] as String?,
  isSevere: json['isSevere'] as bool? ?? false,
);

Map<String, dynamic> _$SymptomToJson(_Symptom instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'recordedAt': instance.recordedAt.toIso8601String(),
  'notes': instance.notes,
  'isSevere': instance.isSevere,
};
