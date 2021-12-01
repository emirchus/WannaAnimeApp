import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/domain/entities/character_entity.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/domain/entities/streamer_entity.dart';
import 'package:wannaanime/domain/entities/streaming_entity.dart';
import 'package:wannaanime/domain/repositories/api_repository.dart';
import 'package:wannaanime/presentation/screens/home_screen.dart';

class GlobalProvider extends ChangeNotifier {

  final ApiRepository _apiRepository;
  final GlobalKey<HomeScreenState> homeScreenKey = GlobalKey<HomeScreenState>();

  GlobalProvider(this._apiRepository);

  bool isLoading = true;
  Random random = Random();

  Color headerColor = Colors.white;

  final List<AnimeEntity> _animes = [];
  final List<AnimeEntity> _trendingAnimes = [];
  final Map<String, List<CharacterEntity>> _charactersByAnime = {};
  final Map<String, List<StreamingEntity>> _streamingsAnime = {};
  final List<StreamerEntity> _streamers = [];

  final List<MangaEntity> _mangas = [];
  final List<MangaEntity> _trendingMangas = [];

  List<AnimeEntity> get animes => _animes;
  List<AnimeEntity> get trendingAnimes => _trendingAnimes;
  List<AnimeEntity> get notAnimes => _animes.where((element) => trendingAnimes.indexWhere((trending) => element.id == trending.id) == -1).toList();

  List<MangaEntity> get mangas => _mangas;
  List<MangaEntity> get trendingMangas => _trendingMangas;
  List<MangaEntity> get notMangas => _mangas.where((element) => trendingMangas.indexWhere((trending) => element.id == trending.id) == -1).toList();

  Future<void> fetchAnimeList() async {
    isLoading = true;
    notify();
    if(_trendingAnimes.length < 10) {
      _trendingAnimes.addAll(await _apiRepository.getTrendingAnimes());
    }
    _animes.addAll(List.generate(10, (index) => AnimeEntity.placeholder()));
    notify();
    _animes.replaceRange(_animes.length - 10, _animes.length, await _apiRepository.getAnimes(start: _animes.length + 1, end: 10));

    if(_streamers.length < 11){
      _streamers.addAll(await _apiRepository.getStreamers());
    }

    isLoading = false;
    notify();
  }

  Future<void> fetchMangaList() async {
    isLoading = true;
    notify();
    if(_trendingMangas.length < 10) {
      _trendingMangas.addAll(await _apiRepository.getTrendingMangas());
    }
    _mangas.addAll(List.generate(10, (index) => MangaEntity.placeholder()));
    notify();

    final response = await _apiRepository.getMangas(start: _mangas.length + 1, end: 10);

    _mangas.replaceRange(_mangas.length - 10, _mangas.length, response);

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

  Future<List<MangaEntity>> searchManga(String name) async {
    List<MangaEntity> result = await _apiRepository.getMangas(search: name.trim());

    mangas.addAll(result.where((element) => mangas.where((anime) => anime.id == element.id).isEmpty).toList());

    return result;
  }

  Future<List<AnimeEntity>> searchAnime(String name) async{
    List<AnimeEntity> result = await _apiRepository.getAnimes(search: name.trim());

    animes.addAll(result.where((element) => animes.where((anime) => anime.id == element.id).isEmpty).toList());

    return result;
  }


  Future<AnimeEntity?> getRandomAnime() async {
    int randomID = random.nextInt(18643);

    AnimeEntity? anime = await _apiRepository.getAnime(randomID.toString());

    if(anime != null && !animes.contains(anime)) {
      animes.add(anime);
      notify();
    }

    return anime;
  }

  static GlobalProvider of(BuildContext context, {listen = true}) => Provider.of<GlobalProvider>(context, listen: listen);

  notify(){
    notifyListeners();
  }

}