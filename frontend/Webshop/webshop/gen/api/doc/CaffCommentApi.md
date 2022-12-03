# api.api.CaffCommentApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiCaffIdCommentCommentIdDelete**](CaffCommentApi.md#apicaffidcommentcommentiddelete) | **DELETE** /api/caff/{id}/comment/{commentId} | 
[**apiCaffIdCommentGet**](CaffCommentApi.md#apicaffidcommentget) | **GET** /api/caff/{id}/comment | 
[**apiCaffIdCommentPost**](CaffCommentApi.md#apicaffidcommentpost) | **POST** /api/caff/{id}/comment | 


# **apiCaffIdCommentCommentIdDelete**
> apiCaffIdCommentCommentIdDelete(id, commentId)



### Example
```dart
import 'package:api/api.dart';

final api_instance = CaffCommentApi();
final id = 56; // int | 
final commentId = 56; // int | 

try {
    api_instance.apiCaffIdCommentCommentIdDelete(id, commentId);
} catch (e) {
    print('Exception when calling CaffCommentApi->apiCaffIdCommentCommentIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **commentId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiCaffIdCommentGet**
> List<CaffCommentResponse> apiCaffIdCommentGet(id)



### Example
```dart
import 'package:api/api.dart';

final api_instance = CaffCommentApi();
final id = 56; // int | 

try {
    final result = api_instance.apiCaffIdCommentGet(id);
    print(result);
} catch (e) {
    print('Exception when calling CaffCommentApi->apiCaffIdCommentGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**List<CaffCommentResponse>**](CaffCommentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiCaffIdCommentPost**
> apiCaffIdCommentPost(id, body)



### Example
```dart
import 'package:api/api.dart';

final api_instance = CaffCommentApi();
final id = 56; // int | 
final body = String(); // String | 

try {
    api_instance.apiCaffIdCommentPost(id, body);
} catch (e) {
    print('Exception when calling CaffCommentApi->apiCaffIdCommentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **body** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

