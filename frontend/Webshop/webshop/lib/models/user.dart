import 'package:api/api.dart';

enum Role { admin, user }

class User {
  final int? id;
  final String? name;
  final String? email;
  final Role role;

  User({this.id, this.name, this.email, this.role = Role.user});

  factory User.from(User profile) => User(
        id: profile.id,
        name: profile.name,
        email: profile.email,
      );

  factory User.fromUserResponse(UserResponse userResponse) => User(
        id: userResponse.id as int,
        name: userResponse.userName,
        email: userResponse.email,
      );

  @override
  String toString() => 'User[name=$name, email=$email, role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null) {
      json[r'name'] = name;
    }
    if (email != null) {
      json[r'email'] = email;
    }
    json[r'role'] = role.toString();

    return json;
  }

  static User? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "User[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "User[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return User(
        name: mapValueOfType<String>(json, r'name'),
        email: mapValueOfType<String>(json, r'email'),
        role: mapValueOfType<Role>(json, r'role') ?? Role.user,
      );
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && other.name == name && other.email == email;

  @override
  int get hashCode => name.hashCode + email.hashCode;

  static const requiredKeys = <String>{
    'role',
  };
}
