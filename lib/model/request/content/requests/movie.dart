import 'package:ombiapp/contracts/media_content_request.dart';

class MovieRequestPodo extends MediaContentRequest {

  MovieRequestPodo(num id) : super(id);

  Map<String, dynamic> toJson() => {
        'theMovieDbId': id,
      };
}
