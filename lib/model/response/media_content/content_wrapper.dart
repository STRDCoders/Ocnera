import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/network_response.dart';

/// Wrap content objects with NetworkResponse for error handling.
class ContentWrapper extends NetworkResponse {

  final List<MediaContent> _content;

  ContentWrapper(num statusCode,this._content) : super(statusCode);

  List<MediaContent> get content => _content;

  @override
  String toString() {
    return 'ContentWrapper{_content: $_content}';
  }


}