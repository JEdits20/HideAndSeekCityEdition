// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) =>
    _LocationInfo(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      creationDate: DateTime.parse(json['creationDate'] as String),
    );

Map<String, dynamic> _$LocationInfoToJson(_LocationInfo instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'creationDate': instance.creationDate.toIso8601String(),
    };
