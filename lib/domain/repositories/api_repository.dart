import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/domain/entities/character_entity.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/domain/entities/streamer_entity.dart';
import 'package:wannaanime/domain/entities/streaming_entity.dart';

abstract class ApiRepository {
  Future<List<AnimeEntity>> getAnimes({int start = 1, int end = 20, String search = ''});

  Future<List<AnimeEntity>> getTrendingAnimes();

  Future<AnimeEntity?> getAnime(String query);

  Future<List<CharacterEntity>> getCharacters({required String id});

  Future<List<StreamerEntity>> getStreamers();

  Future<List<StreamingEntity>> getStreamings({required String id});

  Future<List<MangaEntity>> getMangas({int start = 1, int end = 20, String search = ''});

  Future<List<MangaEntity>> getTrendingMangas();
}
