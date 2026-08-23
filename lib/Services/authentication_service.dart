import 'package:wayko/Services/hive_boxes.dart';
import 'package:wayko/Models/user_model.dart';
import 'package:wayko/Services/session_service.dart';

class AuthenticationService {
  Future<bool> register(String username, String email, String password) async {
    for (UserModel user in HiveBoxes.userBox.values) {
      if (user.email == email) {
        return false;
      }
    }

    String userId = DateTime.now().microsecondsSinceEpoch.toString();

    UserModel newUser = UserModel(
      id: userId,
      username: username,
      email: email,
      password: password,
      createdAt: DateTime.now(),
    );

    await HiveBoxes.userBox.add(newUser);
    return true;
  }

  Future<bool> login(String email, String password) async {
    for (UserModel user in HiveBoxes.userBox.values) {
      if (user.email == email && user.password == password) {
        await SessionService.saveLoginSession(user.id);
        return true;
      }
    }
    return false;
  }
}
