import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/user_model.dart';
import 'package:wayko/Providers/session_provider.dart';
import 'package:wayko/Services/hive_boxes.dart';

class ProfileNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    return ref.watch(currentUserProvider);
  }

  Future<void> loadUser() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      state = null;
      return;
    }

    for (final UserModel currentUser in HiveBoxes.userBox.values) {
      if (currentUser.id == userId) {
        state = currentUser;
        return;
      }
    }
    state = null;
  }

  Future<void> updateProfile({
    required String username,
    required String email,
  }) async {
    final currentUser = state;
    if (currentUser == null) {
      return;
    }

    currentUser.username = username;
    currentUser.email = email;
    await currentUser.save();
    state = currentUser;
  }

  void clearUser() {
    state = null;
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, UserModel?>(
  ProfileNotifier.new,
);
