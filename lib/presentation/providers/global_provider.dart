import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/domain/entities/character_entity.dart';
import 'package:wannaanime/domain/entities/streamer_entity.dart';
import 'package:wannaanime/domain/entities/streaming_entity.dart';
import 'package:wannaanime/domain/repositories/api_repository.dart';

class GlobalProvider extends ChangeNotifier {

  final ApiRepository _apiRepository;

  GlobalProvider(this._apiRepository);

  bool isLoading = true;

  final List<AnimeEntity> _animes = [];
  final List<AnimeEntity> _trendingAnimes = [];
  final Map<String, List<CharacterEntity>> _charactersByAnime = {};
  final Map<String, List<StreamingEntity>> _streamingsAnime = {};
  final List<StreamerEntity> _streamers = [];

  List<AnimeEntity> get animes => _animes;
  List<AnimeEntity> get trendingAnimes => _trendingAnimes;
  List<AnimeEntity> get notAnimes => _animes.where((element) => trendingAnimes.indexWhere((trending) => element.id == trending.id) == -1).toList();

  Future<void> fetchAnimeList() async {
    isLoading = true;
    notify();
    if(_trendingAnimes.length < 10) {
      _trendingAnimes.addAll(await _apiRepository.getTrendingAnimes());
    }
    _animes.addAll(await _apiRepository.getAnimes(start: _animes.length + 1, end: 10));
    if(_streamers.length < 11){
      _streamers.addAll(await _apiRepository.getStreamers());
    }

    isLoading = false;
    notify();
  }

  Future<List<CharacterEntity>> fetchCharacterByAnime(String id) async{
    isLoading = true;
    if(_charactersByAnime[id] == null) {
      _charactersByAnime[id] = await _apiRepository.getCharacters(id: id);
    }
    isLoading = false;
    notify();
    return _charactersByAnime[id]!;
  }

  Future<List<StreamingEntity>> fetchStreamingByAnime(String id) async{
    isLoading = true;
    if(_streamingsAnime[id] == null) {
      _streamingsAnime[id] = await _apiRepository.getStreamings(id: id);
    }
    isLoading = false;
    notify();
    return _streamingsAnime[id]!;
  }

  Future<List<AnimeEntity>> searchAnime(String name) async{
    List<AnimeEntity> result = await _apiRepository.getAnimes(search: name.trim());

    animes.addAll(result.where((element) => animes.where((anime) => anime.id == element.id).isEmpty).toList());

    return result;
  }
  static GlobalProvider of(BuildContext context, {listen = true}) => Provider.of<GlobalProvider>(context, listen: listen);

  notify(){
    notifyListeners();
  }
}