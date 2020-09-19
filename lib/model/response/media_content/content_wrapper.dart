import 'package:ombiapp/contracts/media_content.dart';
import 'package:ombiapp/contracts/network_response.dart';

/// Wrap content objects with NetworkResponse for error handling.
class ContentWrapper extends NetworkResponse {

  final List<num> _contentID;

  ContentWrapper(num statusCode,this._contentID) : super(statusCode);

  List<num> get contentID => _contentID;

  @override
  String toString() {
    return 'ContentWrapper{_content: $_contentID}';
  }


}