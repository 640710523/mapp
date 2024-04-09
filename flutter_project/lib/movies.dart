class movie {
  final String title;
  final String imdbId; 
  final String posterURL;


  movie({
    required this.title,
    required this.imdbId,
    required this.posterURL,

  });

  factory movie.fromJson(Map<String, dynamic> json) {
    return movie(
      title: json['title'],
      imdbId: json['imdbId'],
      posterURL: json['posterURL'],

    );
  }
}