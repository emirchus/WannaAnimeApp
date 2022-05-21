import 'package:wannaanime/domain/dto/anime_dto.dart';
import 'package:wannaanime/domain/dto/animes_dto.dart';

mixin AnimesRepositoryMixin {
  Future<AnimesDTO> getAnimes({int start = 1, int end = 20, String search = ''});

  Future<AnimesDTO> getTrendingAnimes();

  Future<AnimeDTO> getAnime(String query);
}
