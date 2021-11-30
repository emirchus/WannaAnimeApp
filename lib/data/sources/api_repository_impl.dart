import 'dart:developer';

import 'package:wannaanime/data/services/services.dart';
import 'package:wannaanime/domain/dto/anime_dto.dart';
import 'package:wannaanime/domain/dto/animes_dto.dart';
import 'package:wannaanime/domain/dto/characters_dto.dart';
import 'package:wannaanime/domain/dto/streamers_dto.dart';
import 'package:wannaanime/domain/dto/streamings_dto.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/domain/entities/character_entity.dart';
import 'package:wannaanime/domain/entities/streaming_entity.dart';
import 'package:wannaanime/domain/entities/streamer_entity.dart';
import 'package:wannaanime/domain/repositories/api_repository.dart';

class ApiRepositoryImpl extends ApiRepository {
  @override
  Future<AnimeEntity?> getAnime(String query) async {
    AnimeDTO dto = await Services.getAnime(id: query);

    if (dto.statusCode == 200) {
      return dto.toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<List<AnimeEntity>> getAnimes({int start = 1, int end = 20, String search = ''}) async {
    AnimesDTO dto = await Services.getAnimes(start: start, end: end, search: search);
    log(dto.message);
    if (dto.statusCode == 200) {
      return dto.toAnimes()!;
    } else {
      return [];
    }
  }

  @override
  Future<List<AnimeEntity>> getTrendingAnimes({int start = 1, int end = 20}) async {
    AnimesDTO dto = await Services.getTrendingAnimes(start: start, end: end);

    if (dto.statusCode == 200) {
      return dto.toAnimes()!;
    } else {
      return [];
    }
  }

  @override
  Future<List<CharacterEntity>> getCharacters({required String id}) async{
    CharactersDTO dto = await Services.getCharactersAnime(id);

    if(dto.statusCode == 200){
      return dto.toCharacters() ?? [];
    }else{
      return [];
    }
  }

  @override
  Future<List<StreamerEntity>> getStreamers() async {
    StreamersDTO dto = await Services.getStreamers();

    if(dto.statusCode == 200){
      return dto.toStreamers()!;
    }else{
      return [];
    }
  }

  @override
  Future<List<StreamingEntity>> getStreamings({required String id}) async {
    StreamingsDTO dto = await Services.getStreamingFromAnime(id);

    if(dto.statusCode == 200){
      return dto.toStreamings()!;
    }else{
      return [];
    }
  }
}
