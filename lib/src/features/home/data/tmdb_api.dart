import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/constants/constants.dart';
import '../../../../app/errors/errors.dart';
import '../../../models/all_genres_model.dart';
import '../../../models/cast_model.dart';
import '../../../models/movie_details_model.dart';
import '../../../providers/http_base_provider.dart';

///TMDb Provider
final Provider<TMDB> tmdbProvider = Provider<TMDB>(
  name: 'tmdbProvider',
  (ProviderRef<TMDB> ref) => TMDB(client: ref.watch(httpClientProvider)),
);

///Provider to load horror movies
final AutoDisposeFutureProvider<Either<Failure, MovieDetail>>
    horrorMovieProvider =
    FutureProvider.autoDispose<Either<Failure, MovieDetail>>(
  name: 'horrorMovieProvider',
  (AutoDisposeFutureProviderRef<Either<Failure, MovieDetail>> ref) async =>
      ref.watch(tmdbProvider).getGenreWiseMovies(genre: MovieGenre.horror.name),
);

///Provider to load action movies
final AutoDisposeFutureProvider<Either<Failure, MovieDetail>>
    thrillerMovieProvider =
    FutureProvider.autoDispose<Either<Failure, MovieDetail>>(
  name: 'thrillerMovieProvider',
  (AutoDisposeFutureProviderRef<Either<Failure, MovieDetail>> ref) async => ref
      .watch(tmdbProvider)
      .getGenreWiseMovies(genre: MovieGenre.thriller.name),
);

//load cast from the movie Id
final AutoDisposeFutureProviderFamily<Either<Failure, AllCredits>, int>
    castProvider =
    FutureProvider.autoDispose.family<Either<Failure, AllCredits>, int>(
  name: 'castProvider',
  (AutoDisposeFutureProviderRef<Either<Failure, AllCredits>> ref,
          int id) async =>
      ref.watch(tmdbProvider).getCastDetails(id: id),
);

class TMDB {
  late final HttpBaseClient _client;

  TMDB({required HttpBaseClient client}) : _client = client;

  FutureEither<AllGenres> getAllGenres() async {
    Either<Failure, String> data =
        await _client.get('$genreUrl?api_key=$apiKey');
    return data.fold(
      left,
      (String r) => right(AllGenres.fromJson(jsonDecode(r))),
    );
  }

  FutureEither<MovieDetail> getGenreWiseMovies({required String genre}) async {
    Either<Failure, String> data = await _client.get(
        '$searchUrl?api_key=$apiKey&language=en-US&sort_by=popularity.desc&query=$genre');
    return data.fold(
      left,
      (String r) => right(MovieDetail.fromJson(jsonDecode(r))),
    );
  }

  FutureEither<Map<String, dynamic>> findMoviewDetailsById(
      {required int id}) async {
    Either<Failure, String> data =
        await _client.get('$movieUrl/$id?api_key=$apiKey');
    return data.fold(
      left,
      (String r) {
        dynamic result = jsonDecode(r);
        return right(
          <String, dynamic>{
            'isAdult': result['adult'],
            'genres': List<Genre>.from(result['genres']),
            'backdropPath': result['backdrop_path'],
            'homepage': result['homepage'],
            'id': result['id'],
            'originalLanguage': result['original_language'],
            'originalTitle': result['original_title'],
            'overview': result['overview'],
            'popularity': result['popularity'],
            'posterPath': result['poster_path'],
            'title': result['title'],
            'tagline': result['tagline'],
            'voteAverage': result['vote_average'],
          },
        );
      },
    );
  }

  FutureEither<AllCredits> getCastDetails({required int id}) async {
    Either<Failure, String> data =
        await _client.get('$movieUrl/$id/credits?api_key=$apiKey');
    return data.fold(
      left,
      (String r) => right(AllCredits.fromJson(jsonDecode(r))),
    );
  }

  FutureEither<MovieDetail> searchMovie(String query,
      {bool isAdult = false, int page = 1}) async {
    Either<Failure, String> data = await _client.get(
        '$searchUrl?api_key=$apiKey&language=en-US&query=$query&page=$page&include_adult=$isAdult');
    return data.fold(
      left,
      (String r) => right(MovieDetail.fromJson(jsonDecode(r))),
    );
  }

  ///Get the trending/popular movies from TMDB
  FutureEither<MovieDetail> getTrendingMovies({int page = 1}) async {
    Either<Failure, String> data =
        await _client.get('$movieUrl/popular?api_key=$apiKey&page=$page');
    return data.fold(
      left,
      (String r) => right(MovieDetail.fromJson(jsonDecode(r))),
    );
  }
}
