import '../models/user.dart';

class FakeAuth {
  static User? currentUser;

  static final List<User> _users = [
    User(
      email: 'cliente@demo.com',
      type: UserType.cliente,
    ),
    User(
      email: 'coop@demo.com',
      type: UserType.cooperativa,
    ),
  ];

  static bool login(
    String email,
    String password,
    UserType selectedType,
  ) {
    try {
      final user = _users.firstWhere(
        (u) => u.email == email,
      );

      currentUser = user;
      return true;
    } catch (_) {
      return false;
    }
  }

  static void register(
    String email,
    String password,
    UserType type,
  ) {
    final user = User(
      email: email,
      type: type,
    );

    _users.add(user);
    currentUser = user;
  }

  static void logout() {
    currentUser = null;
  }
}
