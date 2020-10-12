import 'package:ombiapp/contracts/network_response.dart';

class MediaContentRequestResponse extends NetworkResponse {
  bool result, isError;
  String message, errorMessage;
  num requestId, contentId;

  MediaContentRequestResponse(num statusCode) : super(statusCode);

  MediaContentRequestResponse.fromJson(Map<String, dynamic> json, contentId)
      : super(200) {
    this.result = json['result'];
    this.isError = json['isError'];
    this.message = json['message'];
    this.errorMessage = json['errorMessage'];
    this.requestId = json['requestId'];
    this.contentId = contentId;
  }

  @override
  String toString() {
    return 'MediaContentRequestResponse{result: $result, isError: $isError, message: $message, errorMessage: $errorMessage, requestId: $requestId, contentId: $contentId}';
  }
}
