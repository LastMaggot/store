import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable(explicitToJson: true)
class Customer {
  int? id;
  String? account;
  String? password;
  String? username;
  String? address;
  CustomerLevel? level;
  DateTime? registrationDate;
  double? totalSpent;
  String? phoneNumber;
  String? email;

  Customer({
    this.id,
    this.account,
    this.password,
    this.username,
    this.address,
    this.level,
    this.registrationDate,
    this.totalSpent,
    this.phoneNumber,
    this.email,
  });


  @override
  String toString() {
    return 'Customer{id: $id, account: $account, password: $password, username: $username, address: $address, level: $level, registrationDate: $registrationDate, totalSpent: $totalSpent, phoneNumber: $phoneNumber, email: $email}';
  }

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