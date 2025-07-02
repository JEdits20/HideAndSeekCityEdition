import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_info.freezed.dart';
part 'location_info.g.dart';

@freezed
abstract class LocationInfo with _$LocationInfo {
  const factory LocationInfo({
    required double longitude,
    required double latitude,

    /// creation of the location
    required DateTime creationDate,
  }) = _LocationInfo;

  factory LocationInfo.fromJson(Map<String, Object?> json) => _$LocationInfoFromJson(json);
}
