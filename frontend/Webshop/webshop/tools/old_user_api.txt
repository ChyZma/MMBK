//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserApi {
  UserApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /api/User' operation and returns the [Response].
  Future<Response> apiUserGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/User';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<List<UserResponse>?> apiUserGet() async {
    final response = await apiUserGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<UserResponse>') as List)
          .cast<UserResponse>()
          .toList();
    }
    return null;
  }

  /// Performs an HTTP 'DELETE /api/User/{id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> apiUserIdDeleteWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/api/User/{id}'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> apiUserIdDelete(
    String id,
  ) async {
    final response = await apiUserIdDeleteWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /api/User/login' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [LoginRequest] loginRequest:
  Future<Response> apiUserLoginPostWithHttpInfo({
    LoginRequest? loginRequest,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/User/login';

    // ignore: prefer_final_locals
    Object? postBody = loginRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[
      'application/json',
      'text/json',
      'application/_*+json'
    ];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [LoginRequest] loginRequest:
  Future<Token?> apiUserLoginPost({
    LoginRequest? loginRequest,
  }) async {
    final response = await apiUserLoginPostWithHttpInfo(
      loginRequest: loginRequest,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'Token',
      ) as Token;
    }
    return null;
  }

  /// Performs an HTTP 'POST /api/User/make-admin' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [MakeAdminRequest] makeAdminRequest:
  Future<Response> apiUserMakeAdminPostWithHttpInfo({
    MakeAdminRequest? makeAdminRequest,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/User/make-admin';

    // ignore: prefer_final_locals
    Object? postBody = makeAdminRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[
      'application/json',
      'text/json',
      'application/_*+json'
    ];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [MakeAdminRequest] makeAdminRequest:
  Future<void> apiUserMakeAdminPost({
    MakeAdminRequest? makeAdminRequest,
  }) async {
    final response = await apiUserMakeAdminPostWithHttpInfo(
      makeAdminRequest: makeAdminRequest,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /api/User/register' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [RegisterRequest] registerRequest:
  Future<Response> apiUserRegisterPostWithHttpInfo({
    RegisterRequest? registerRequest,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/User/register';

    // ignore: prefer_final_locals
    Object? postBody = registerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[
      'application/json',
      'text/json',
      'application/_*+json'
    ];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [RegisterRequest] registerRequest:
  Future<void> apiUserRegisterPost({
    RegisterRequest? registerRequest,
  }) async {
    final response = await apiUserRegisterPostWithHttpInfo(
      registerRequest: registerRequest,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}

class Token {
  Token({
    required this.token,
    required this.expiration,
  });

  String token;

  String expiration;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Token && other.token == token && other.expiration == expiration;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (token.hashCode) + (expiration.hashCode);

  @override
  String toString() => 'Token[token=$token, expiration=$expiration]';

  // ignore: prefer_constructors_over_static_methods
  static Token? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "Token[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "Token[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Token(
        token: mapValueOfType<String>(json, r'token')!,
        expiration: mapValueOfType<String>(json, r'expiration')!,
      );
    }
    return null;
  }

  static List<Token>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <Token>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Token.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Token> mapFromJson(dynamic json) {
    final map = <String, Token>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Token.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  static Map<String, List<Token>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<Token>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Token.listFromJson(
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
  static const requiredKeys = <String>{
    'token',
    'expiration',
  };
}
