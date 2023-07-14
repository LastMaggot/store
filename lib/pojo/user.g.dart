// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as int?,
      username: json['username'] as String?,
      level: $enumDecodeNullable(_$CustomerLevelEnumMap, json['level']),
      registrationDate: json['registrationDate'] == null
          ? null
          : DateTime.parse(json['registrationDate'] as String),
      totalSpent: (json['totalSpent'] as num?)?.toDouble(),
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'level': _$CustomerLevelEnumMap[instance.level],
      'registrationDate': instance.registrationDate?.toIso8601String(),
      'totalSpent': instance.totalSpent,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
    };

const _$CustomerLevelEnumMap = {
  CustomerLevel.normal: 'normal',
  CustomerLevel.bronze: 'bronze',
  CustomerLevel.silver: 'silver',
  CustomerLevel.gold: 'gold',
};
