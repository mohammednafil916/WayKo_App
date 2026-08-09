class AuthenticationService {
  static bool isLoggedIn = false;
  static String? isLoggedInEmail;

  static String? registerName;
  static String? registerEmail;
  static String? registerPassword;

  static void register(String name, String email, String password) {
    registerName = name;
    registerEmail = email;
    registerPassword = password;
  }

  static bool login(String email, String password) {
    if (email == registerEmail && password == registerPassword) {
      isLoggedIn = true;
      isLoggedInEmail = email;

      return true;
    }

    return false;
  }

  static void logout() {
    isLoggedIn = false;
    isLoggedInEmail = null;
  }
}
