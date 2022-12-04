//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CaffUploadRequest {
  /// Returns a new [CaffUploadRequest] instance.
  CaffUploadRequest({
    this.file,
  });

  MultipartFile? file;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaffUploadRequest && other.file == file;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (file == null ? 0 : file!.hashCode);

  @override
  String toString() => 'CaffUploadRequest[file=$file]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (file != null) {
      _json[r'file'] = file;
    }
    return _json;
  }

  /// Returns a new [CaffUploadRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CaffUploadRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "CaffUploadRequest[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "CaffUploadRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CaffUploadRequest(
        file: null, // No support for decoding binary content from JSON
      );
    }
    return null;
  }

  static List<CaffUploadRequest>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <CaffUploadRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CaffUploadRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CaffUploadRequest> mapFromJson(dynamic json) {
    final map = <String, CaffUploadRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CaffUploadRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CaffUploadRequest-objects as value to a dart map
  static Map<String, List<CaffUploadRequest>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<CaffUploadRequest>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CaffUploadRequest.listFromJson(
          entry.value,
          growable: growable,
        );
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}
