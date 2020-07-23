import 'package:global_configuration/global_configuration.dart';

enum ContentType  { MOVIE , SERIES }

extension RoutesExtension on ContentType {
  static String _value(ContentType val) {
    switch (val) {
      case ContentType.MOVIE:
        return GlobalConfiguration().getString('API_LINK_SEARCH_QUERY_MOVIE');
        break;
      case ContentType.SERIES:
        return GlobalConfiguration().getString('API_LINK_SEARCH_QUERY_SERIES');
        break;
    }
  }

  String get value => _value(this);
}