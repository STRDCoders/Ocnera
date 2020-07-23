import 'package:ombiapp/contracts/network_response.dart';

abstract class Content extends NetworkResponse {
  String title, banner, overview;
  DateTime releaseDate;

  Content(num statusCode) : super(statusCode);



}