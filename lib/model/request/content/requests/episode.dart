class EpisodeRequest {
  final num _id;

  EpisodeRequest(this._id);

  Map<String, dynamic> toJson() => {
    'episodeNumber': _id,
  };
}