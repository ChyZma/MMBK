//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CaffResponse {
  /// Returns a new [CaffResponse] instance.
  CaffResponse({
    this.id,
    this.tags = const [],
    this.fileName,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  List<String>? tags;

  String? fileName;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CaffResponse &&
     other.id == id &&
     other.tags == tags &&
     other.fileName == fileName;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (tags == null ? 0 : tags!.hashCode) +
    (fileName == null ? 0 : fileName!.hashCode);

  @override
  String toString() => 'CaffResponse[id=$id, tags=$tags, fileName=$fileName]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (id != null) {
      _json[r'id'] = id;
    }
    if (tags != null) {
      _json[r'tags'] = tags;
    }
    if (fileName != null) {
      _json[r'fileName'] = fileName;
    }
    return _json;
  }

  /// Returns a new [CaffResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CaffResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CaffResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CaffResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CaffResponse(
        id: mapValueOfType<int>(json, r'id'),
        tags: json[r'tags'] is List
            ? (json[r'tags'] as List).cast<String>()
            : const [],
        fileName: mapValueOfType<String>(json, r'fileName'),
      );
    }
    return null;
  }

  static List<CaffResponse>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CaffResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CaffResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CaffResponse> mapFromJson(dynamic json) {
    final map = <String, CaffResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CaffResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CaffResponse-objects as value to a dart map
  static Map<String, List<CaffResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CaffResponse>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CaffResponse.listFromJson(entry.value, growable: growable,);
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

