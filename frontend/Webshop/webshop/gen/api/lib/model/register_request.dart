//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RegisterRequest {
  /// Returns a new [RegisterRequest] instance.
  RegisterRequest({
    this.userName,
    this.password,
    this.email,
  });

  String? userName;

  String? password;

  String? email;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RegisterRequest &&
     other.userName == userName &&
     other.password == password &&
     other.email == email;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (userName == null ? 0 : userName!.hashCode) +
    (password == null ? 0 : password!.hashCode) +
    (email == null ? 0 : email!.hashCode);

  @override
  String toString() => 'RegisterRequest[userName=$userName, password=$password, email=$email]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (userName != null) {
      _json[r'userName'] = userName;
    }
    if (password != null) {
      _json[r'password'] = password;
    }
    if (email != null) {
      _json[r'email'] = email;
    }
    return _json;
  }

  /// Returns a new [RegisterRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RegisterRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RegisterRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RegisterRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RegisterRequest(
        userName: mapValueOfType<String>(json, r'userName'),
        password: mapValueOfType<String>(json, r'password'),
        email: mapValueOfType<String>(json, r'email'),
      );
    }
    return null;
  }

  static List<RegisterRequest>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RegisterRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RegisterRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RegisterRequest> mapFromJson(dynamic json) {
    final map = <String, RegisterRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RegisterRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RegisterRequest-objects as value to a dart map
  static Map<String, List<RegisterRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RegisterRequest>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RegisterRequest.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

