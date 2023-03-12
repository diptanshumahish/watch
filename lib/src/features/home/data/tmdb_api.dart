import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/app/constants/constants.dart';
import 'package:watch/app/errors/errors.dart';
import 'package:watch/src/models/all_genres_model.dart';
import 'package:watch/src/models/genres_model.dart';
import 'package:watch/src/providers/http_base_provider.dart';

///TMDb Provider
final tmdbProvider = Provider<TMDB>(
  (ref) => TMDB(client: ref.watch(httpClientProvider)),
);

///Provider to load horror movies
final horrorMovieProvider =
    FutureProvider.autoDispose<Either<Failure, GenreById>>(
  (ref) async => await ref
      .watch(tmdbProvider)
      .getGenreWiseMovies(genre: MovieGenre.horror.name),
);

///Provider to load action movies
final thrillerMovieProvider =
    FutureProvider.autoDispose<Either<Failure, GenreById>>(
  (ref) async => await ref
      .watch(tmdbProvider)
      .getGenreWiseMovies(genre: MovieGenre.thriller.name),
);

class TMDB {
  late final HttpBaseClient _client;

  TMDB({required HttpBaseClient client}) : _client = client;

  FutureEither<List<Genre>> getAllGenres() async {
    Either<Failure, String> data =
        await _client.get('$genreUrl?api_key=$apiKey');
    return data.fold(
      (l) => left(l),
      (r) {
        var result = jsonDecode(r)["genres"] as List<Genre>;
        List<Genre> temp = [];
        for (var item in result) {
          temp.add(Genre(id: item.id, name: item.name));
        }
        return right(temp);
      },
    );
  }

  FutureEither<GenreById> getGenreWiseMovies({required String genre}) async {
    Either<Failure, String> data = await _client.get(
        '$searchUrl?api_key=$apiKey&language=en-US&sort_by=popularity.desc&query=$genre');
    return data.fold(
      (l) => left(l),
      (r) => right(GenreById.fromJson(jsonDecode(r))),
    );
  }
}
