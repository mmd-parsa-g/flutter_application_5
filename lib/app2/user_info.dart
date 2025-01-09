import 'package:hive_flutter/hive_flutter.dart';

part 'user_info.g.dart';

@HiveType(typeId: 0)
class UserInfo {
  @HiveField(0)
  final String firstName;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final int number;

  UserInfo({
    required this.firstName,
    required this.lastName,
    required this.number,
  });
}

