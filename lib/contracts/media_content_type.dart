import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

enum MediaContentType { MOVIE, SERIES }

extension ContentTypeExtention on MediaContentType {
  /// Choose correct API URL for query search.
  static String _querySearch(MediaContentType val) {
    switch (val) {
      case MediaContentType.MOVIE:
        return GlobalConfiguration().get('API_LINK_SEARCH_QUERY_MOVIE');
        break;
      case MediaContentType.SERIES:
        return GlobalConfiguration().get('API_LINK_SEARCH_QUERY_SERIES');
        break;
    }
  }

  static IconData _icon(MediaContentType val) {
    switch (val) {
      case MediaContentType.MOVIE:
        return Icons.movie;
        break;
      case MediaContentType.SERIES:
        return Icons.tv;
        break;
    }
  }

  /// Fetch prefix URL to banner images.
  static String _prefixImageLink(MediaContentType val) {
    switch (val) {
      case MediaContentType.MOVIE:
        return GlobalConfiguration().get('API_LINK_CONTENT_MOVIE_POSTER');
        break;
      case MediaContentType.SERIES:
        return "";
        break;
    }
  }

  /// Choose correct API link for extended information.
  static String _extendedInfoLink(MediaContentType val) {
    switch (val) {
      case MediaContentType.MOVIE:
        return GlobalConfiguration().get('API_LINK_SEARCH_INFO_MOVIE');
        break;
      case MediaContentType.SERIES:
        return GlobalConfiguration().get('API_LINK_SEARCH_INFO_SERIES');
        break;
    }
  }

  /// Build banner link for content.
  /// Here you might manipulate the URL to get different resolutions of images.
  static String _optimizedBanner(String url, MediaContentType type) {
    switch (type) {
      case MediaContentType.MOVIE:
        return "${MediaContentType.MOVIE.imageLink}/$url";
        break;
      case MediaContentType.SERIES:
        return "${MediaContentType.SERIES.imageLink}$url";
        break;
    }
  }

  static DateTime _toDate(String date, MediaContentType type) {
    try {
      switch (type) {
        case MediaContentType.MOVIE:
          return DateTime.parse(date);
          break;
        case MediaContentType.SERIES:
          return DateTime.parse(date);
          break;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Choose correct link for default content search
  static String _defaultSearchContent(MediaContentType type) {
    switch (type) {
      case MediaContentType.MOVIE:
        return GlobalConfiguration()
            .get('API_LINK_SEARCH_MOVIE_DEFAULT_CONTENT');
        break;
      case MediaContentType.SERIES:
        return GlobalConfiguration().get('API_LINK_SEARCH_TV_DEFAULT_CONTENT');
        break;
    }
  }

  String get infoLink => _extendedInfoLink(this);

  String get imageLink => _prefixImageLink(this);

  String get queryLink => _querySearch(this);

  String get defaultContentLink => _defaultSearchContent(this);

  String optimizedBanner(String url) => _optimizedBanner(url, this);

  DateTime dateTime(String date) => _toDate(date, this);

  IconData get icon => _icon(this);
}
