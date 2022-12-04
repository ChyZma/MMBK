# api.api.CaffApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiCaffGet**](CaffApi.md#apicaffget) | **GET** /api/Caff | 
[**apiCaffIdDelete**](CaffApi.md#apicaffiddelete) | **DELETE** /api/Caff/{id} | 
[**apiCaffIdGet**](CaffApi.md#apicaffidget) | **GET** /api/Caff/{id} | 
[**apiCaffIdPreviewGet**](CaffApi.md#apicaffidpreviewget) | **GET** /api/Caff/{id}/preview | 
[**apiCaffPost**](CaffApi.md#apicaffpost) | **POST** /api/Caff | 


# **apiCaffGet**
> List<CaffResponse> apiCaffGet()



### Example
```dart
import 'package:api/api.dart';

final api_instance = CaffApi();

try {
    final result = api_instance.apiCaffGet();
    print(result);
} catch (e) {
    print('Exception when calling CaffApi->apiCaffGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<CaffResponse>**](CaffResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiCaffIdDelete**
> apiCaffIdDelete(id)



### Example
```dart
import 'package:api/api.dart';

final api_instance = CaffApi();
final id = 56; // int | 

try {
    api_instance.apiCaffIdDelete(id);
} catch (e) {
    print('Exception when calling CaffApi->apiCaffIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiCaffIdGet**
> apiCaffIdGet(id)



### Example
```dart
import 'package:api/api.dart';

final api_instance = CaffApi();
final id = 56; // int | 

try {
    api_instance.apiCaffIdGet(id);
} catch (e) {
    print('Exception when calling CaffApi->apiCaffIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiCaffIdPreviewGet**
> apiCaffIdPreviewGet(id)



### Example
```dart
import 'package:api/api.dart';

final api_instance = CaffApi();
final id = 56; // int | 

try {
    api_instance.apiCaffIdPreviewGet(id);
} catch (e) {
    print('Exception when calling CaffApi->apiCaffIdPreviewGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiCaffPost**
> apiCaffPost(caffUploadRequest)



### Example
```dart
import 'package:api/api.dart';

final api_instance = CaffApi();
final caffUploadRequest = CaffUploadRequest(); // CaffUploadRequest | 

try {
    api_instance.apiCaffPost(caffUploadRequest);
} catch (e) {
    print('Exception when calling CaffApi->apiCaffPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caffUploadRequest** | [**CaffUploadRequest**](CaffUploadRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

