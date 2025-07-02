// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationInfo {

 double get longitude; double get latitude;/// creation of the location
 DateTime get creationDate;
/// Create a copy of LocationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationInfoCopyWith<LocationInfo> get copyWith => _$LocationInfoCopyWithImpl<LocationInfo>(this as LocationInfo, _$identity);

  /// Serializes this LocationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationInfo&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,longitude,latitude,creationDate);

@override
String toString() {
  return 'LocationInfo(longitude: $longitude, latitude: $latitude, creationDate: $creationDate)';
}


}

/// @nodoc
abstract mixin class $LocationInfoCopyWith<$Res>  {
  factory $LocationInfoCopyWith(LocationInfo value, $Res Function(LocationInfo) _then) = _$LocationInfoCopyWithImpl;
@useResult
$Res call({
 double longitude, double latitude, DateTime creationDate
});




}
/// @nodoc
class _$LocationInfoCopyWithImpl<$Res>
    implements $LocationInfoCopyWith<$Res> {
  _$LocationInfoCopyWithImpl(this._self, this._then);

  final LocationInfo _self;
  final $Res Function(LocationInfo) _then;

/// Create a copy of LocationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? longitude = null,Object? latitude = null,Object? creationDate = null,}) {
  return _then(_self.copyWith(
longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LocationInfo implements LocationInfo {
  const _LocationInfo({required this.longitude, required this.latitude, required this.creationDate});
  factory _LocationInfo.fromJson(Map<String, dynamic> json) => _$LocationInfoFromJson(json);

@override final  double longitude;
@override final  double latitude;
/// creation of the location
@override final  DateTime creationDate;

/// Create a copy of LocationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationInfoCopyWith<_LocationInfo> get copyWith => __$LocationInfoCopyWithImpl<_LocationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationInfo&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,longitude,latitude,creationDate);

@override
String toString() {
  return 'LocationInfo(longitude: $longitude, latitude: $latitude, creationDate: $creationDate)';
}


}

/// @nodoc
abstract mixin class _$LocationInfoCopyWith<$Res> implements $LocationInfoCopyWith<$Res> {
  factory _$LocationInfoCopyWith(_LocationInfo value, $Res Function(_LocationInfo) _then) = __$LocationInfoCopyWithImpl;
@override @useResult
$Res call({
 double longitude, double latitude, DateTime creationDate
});




}
/// @nodoc
class __$LocationInfoCopyWithImpl<$Res>
    implements _$LocationInfoCopyWith<$Res> {
  __$LocationInfoCopyWithImpl(this._self, this._then);

  final _LocationInfo _self;
  final $Res Function(_LocationInfo) _then;

/// Create a copy of LocationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? longitude = null,Object? latitude = null,Object? creationDate = null,}) {
  return _then(_LocationInfo(
longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
