import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  @HiveField(4)
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
  });
}
