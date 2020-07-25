import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

enum MediaContentType  { MOVIE , SERIES }
//TODO - Ask Amir what he thinks, keep the extensions in here or move the logic to ContentUtilizerManager
//TODO - With Amir, change Enum to Dictionary?
//Maybe it should be here since no manipulation to the data is preformed, its straight forward if A then X or B then Y.
extension ContentTypeExtention on MediaContentType {
  static String _querySearch (MediaContentType val) {
    switch (val) {
      case MediaContentType.MOVIE:
        return GlobalConfiguration().get('API_LINK_SEARCH_QUERY_MOVIE');
        break;
      case MediaContentType.SERIES:
        return GlobalConfiguration().get('API_LINK_SEARCH_QUERY_SERIES');
        break;
    }
  }
  static IconData _icon (MediaContentType val) {
    switch (val) {
      case MediaContentType.MOVIE:
        return Icons.movie;
        break;
      case MediaContentType.SERIES:
        return Icons.tv;
        break;
    }
  }
  static String _prefixImageLink (MediaContentType val) {
    switch (val) {
      case MediaContentType.MOVIE:
        return GlobalConfiguration().get('API_LINK_CONTENT_MOVIE_POSTER');
        break;
      case MediaContentType.SERIES:
        return "";
        break;
    }
  }

  static String _extendedInfoLink (MediaContentType val) {
    switch(val){

      case MediaContentType.MOVIE:
        return GlobalConfiguration().get('API_LINK_SEARCH_INFO_MOVIE');
        break;
      case MediaContentType.SERIES:
        return GlobalConfiguration().get('API_LINK_SEARCH_INFO_SERIES');
        break;
    }
  }
  String get infoLink => _extendedInfoLink(this);
  String get imageLink => _prefixImageLink(this);
  String get queryLink => _querySearch(this);
  IconData get icon => _icon(this);
}