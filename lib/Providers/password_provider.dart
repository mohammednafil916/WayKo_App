import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Providers/session_provider.dart';

class PasswordNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return AsyncData(null);
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    state = AsyncLoading();

    try {
      final user = ref.read(currentUserProvider);

      if (user == null) {
        state = AsyncData(null);
        return false;
      }

      if (currentPassword.isEmpty ||
          newPassword.isEmpty ||
          confirmPassword.isEmpty) {
        state = AsyncData(null);
        return false;
      }

      if (currentPassword != user.password) {
        state = AsyncData(null);
        return false;
      }

      if (newPassword.length < 6) {
        state = AsyncData(null);
        return false;
      }

      if (newPassword != confirmPassword) {
        state = AsyncData(null);
        return false;
      }

      user.password = newPassword;
      await user.save();

      state = AsyncData(null);
      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return false;
    }
  }
}

final passwordProvider = NotifierProvider<PasswordNotifier, AsyncValue<void>>(
  PasswordNotifier.new,
);
