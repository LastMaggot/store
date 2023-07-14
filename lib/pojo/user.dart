import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class Customer {
  int? id;
  String? username;
  CustomerLevel? level;
  DateTime? registrationDate;
  double? totalSpent;
  String? phoneNumber;
  String? email;

  Customer({
    this.id,
    this.username,
    this.level,
    this.registrationDate,
    this.totalSpent,
    this.phoneNumber,
    this.email,
  });

  factory Customer.fromJson(Map<String,dynamic> json) => _$CustomerFromJson(json);

  Map<String,dynamic> toJson() => _$CustomerToJson(this);

  String? getLevelString() {
    if(level == null) {
      return "未知级别";
    }
    switch(level) {
      case CustomerLevel.gold:
        return "金牌客户";
      case CustomerLevel.silver:
        return "银牌客户";
      case CustomerLevel.bronze:
        return "铜牌客户";
      default:
        return "未知级别";
    }
  }

}

enum CustomerLevel {
  normal,
  bronze,
  silver,
  gold,
}