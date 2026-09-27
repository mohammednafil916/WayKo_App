import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Services/authentication_service.dart';

class AuthNotifier extends Notifier<AsyncValue<void>> {
  final AuthenticationService authService = AuthenticationService();

  @override
  AsyncValue<void> build() {
    return AsyncData(null);
  }

  Future<bool> login(String email, String password) async {
    state = AsyncLoading();

    final success = await authService.login(email, password);

    if (success) {
      state = AsyncData(null);
      return true;
    } else {
      state = AsyncData(null);
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    state = AsyncLoading();

    final success = await authService.register(username, email, password);

    if (success) {
      state = AsyncData(null);
      return true;
    } else {
      state = AsyncData(null);
      return false;
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AsyncValue<void>>(
  AuthNotifier.new,
);
