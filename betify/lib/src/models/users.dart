class User {
  final String id;
  final String username;
  final String email;
  final String avatarUrl;
  final String role;
  final bool isEmailVerified;
  final int captchaTicker;
  final int premium;

  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id, 
    required this.username, 
    required this.email,
    required this.avatarUrl,
    required this.role,
    required this.isEmailVerified,
    required this.captchaTicker,
    required this.premium,
    required this.createdAt,
    required this.updatedAt,
  });

  User.fromMap(Map<String, dynamic> parsedJson) :
    id = parsedJson['id'],
    username = parsedJson['username'],
    email = parsedJson['email'],
    avatarUrl = parsedJson['avatarUrl'],
    role = parsedJson['role'],
    isEmailVerified = parsedJson['isEmailVerified'],
    captchaTicker = parsedJson['captchaTicker'],
    premium = parsedJson['premium'],
    createdAt = DateTime.parse(parsedJson['_createdAt']),
    updatedAt = DateTime.parse(parsedJson['_updatedAt']);

  @override
  String toString() {
    return 'User id: $id, username: $username, email: $email, avatarUrl: $avatarUrl';
  }
}