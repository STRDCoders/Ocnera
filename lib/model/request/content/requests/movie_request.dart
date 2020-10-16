import 'package:ombiapp/contracts/media_content_request.dart';

class MovieRequest extends MediaContentRequest {
  MovieRequest(num id) : super(id);

  Map<String, dynamic> toJson() => {
        'theMovieDbId': id,
      };
}
