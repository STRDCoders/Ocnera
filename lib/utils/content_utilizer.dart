import 'package:ombiapp/contracts/media_content_type.dart';

/// Responsible for getting a correct image to content.
class MediaContentConverter {
  /// Responsible for building a URL for an optimized version of a given content image.
  /// Ex. Series posters links come from the API at medium size, we want to make it small to reduce network traffic.
  //TODO - Move those functions to the MediaContentTypeExtension.
//  static String optimizeBanner(String url, MediaContentType type) {
//    switch (type) {
//      case MediaContentType.MOVIE:
//        return "${MediaContentType.MOVIE.imageLink}/$url";
//        break;
//      case MediaContentType.SERIES:
//        return "${MediaContentType.SERIES.imageLink}$url"
//            .replaceFirst("/medium_portrait/", "/small_portrait/");
//        break;
//    }
//  }

  /// Convert The given String to DateTime objects. It might be different between the 2 content types.
//  static DateTime toDate(String date, MediaContentType type) {
//    try {
//      switch (type) {
//        case MediaContentType.MOVIE:
//          return DateTime.parse(date);
//          break;
//        case MediaContentType.SERIES:
//          return DateTime.parse(date);
//          break;
//      }
//    } catch (e) {
//      print(e);
//      return null;
//    }
//  }



}
