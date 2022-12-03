# api.api.UserApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiUserGet**](UserApi.md#apiuserget) | **GET** /api/User | 
[**apiUserIdDelete**](UserApi.md#apiuseriddelete) | **DELETE** /api/User/{id} | 
[**apiUserLoginPost**](UserApi.md#apiuserloginpost) | **POST** /api/User/login | 
[**apiUserMakeAdminPost**](UserApi.md#apiusermakeadminpost) | **POST** /api/User/make-admin | 
[**apiUserRegisterPost**](UserApi.md#apiuserregisterpost) | **POST** /api/User/register | 


# **apiUserGet**
> List<UserResponse> apiUserGet()



### Example
```dart
import 'package:api/api.dart';

final api_instance = UserApi();

try {
    final result = api_instance.apiUserGet();
    print(result);
} catch (e) {
    print('Exception when calling UserApi->apiUserGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<UserResponse>**](UserResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserIdDelete**
> apiUserIdDelete(id)



### Example
```dart
import 'package:api/api.dart';

final api_instance = UserApi();
final id = id_example; // String | 

try {
    api_instance.apiUserIdDelete(id);
} catch (e) {
    print('Exception when calling UserApi->apiUserIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserLoginPost**
> apiUserLoginPost(loginRequest)



### Example
```dart
import 'package:api/api.dart';

final api_instance = UserApi();
final loginRequest = LoginRequest(); // LoginRequest | 

try {
    api_instance.apiUserLoginPost(loginRequest);
} catch (e) {
    print('Exception when calling UserApi->apiUserLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequest** | [**LoginRequest**](LoginRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserMakeAdminPost**
> apiUserMakeAdminPost(makeAdminRequest)



### Example
```dart
import 'package:api/api.dart';

final api_instance = UserApi();
final makeAdminRequest = MakeAdminRequest(); // MakeAdminRequest | 

try {
    api_instance.apiUserMakeAdminPost(makeAdminRequest);
} catch (e) {
    print('Exception when calling UserApi->apiUserMakeAdminPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **makeAdminRequest** | [**MakeAdminRequest**](MakeAdminRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserRegisterPost**
> apiUserRegisterPost(registerRequest)



### Example
```dart
import 'package:api/api.dart';

final api_instance = UserApi();
final registerRequest = RegisterRequest(); // RegisterRequest | 

try {
    api_instance.apiUserRegisterPost(registerRequest);
} catch (e) {
    print('Exception when calling UserApi->apiUserRegisterPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerRequest** | [**RegisterRequest**](RegisterRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

