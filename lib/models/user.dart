enum UserType {
  cliente,
  cooperativa,
}

class User {
  final String email;
  final UserType type;

  User({
    required this.email,
    required this.type,
  });
}
