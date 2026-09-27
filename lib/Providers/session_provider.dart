import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/user_model.dart';
import 'package:wayko/Services/authentication_service.dart';
import 'package:wayko/Services/hive_boxes.dart';
import 'package:wayko/Services/session_service.dart';

class SessionStateNotifier extends Notifier<AsyncValue<String?>> {
  final AuthenticationService _authService = AuthenticationService();

  @override
  AsyncValue<String?> build() {
    _initSession();
    return AsyncLoading();
  }

  Future<void> _initSession() async {
    try {
      final userId = await SessionService.getLoggedUserId();
      state = AsyncData(userId);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<bool> checkLoggedIn() async {
    final userId = await SessionService.getLoggedUserId();
    state = AsyncData(userId);
    return userId != null;
  }

  Future<bool> login(String email, String password) async {
    state = AsyncLoading();
    try {
      final success = await _authService.login(email, password);
      if (success) {
        final userId = await SessionService.getLoggedUserId();
        state = AsyncData(userId);
        return true;
      }
      state = AsyncData(null);
      return false;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    state = AsyncLoading();
    try {
      final success = await _authService.register(username, email, password);
      state = AsyncData(null);
      return success;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<void> logout() async {
    await SessionService.logout();
    state = AsyncData(null);
  }
}

final sessionProvider =
    NotifierProvider<SessionStateNotifier, AsyncValue<String?>>(
      SessionStateNotifier.new,
    );

final currentUserIdProvider = Provider<String?>((ref) {
  final sessionState = ref.watch(sessionProvider);
  return sessionState.value;
});

final currentUserProvider = Provider<UserModel?>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return null;

  for (final UserModel user in HiveBoxes.userBox.values) {
    if (user.id == userId) {
      return user;
    }
  }
  return null;
});
