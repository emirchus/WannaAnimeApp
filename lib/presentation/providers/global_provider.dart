import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wannaanime/domain/entities/anime.dart';
import 'package:wannaanime/domain/entities/character.dart';
import 'package:wannaanime/domain/entities/manga.dart';
import 'package:wannaanime/domain/entities/streamer.dart';
import 'package:wannaanime/domain/entities/streaming.dart';
import 'package:wannaanime/domain/repositories/api_repository.dart';
import 'package:wannaanime/presentation/screens/home_screen.dart';

class GlobalProvider extends ChangeNotifier {
  final ApiRepository _apiRepository;
  final GlobalKey<HomeScreenState> homeScreenKey = GlobalKey<HomeScreenState>();

  GlobalProvider(this._apiRepository);

  bool isLoading = true;
  Random random = Random();

  Color headerColor = Colors.white;

  final List<Anime> _animes = [];
  final List<Anime> _trendingAnimes = [];
  final Map<String, List<Character>> _charactersByAnime = {};
  final Map<String, List<Streaming>> _streamingsAnime = {};
  final List<Streamer> _streamers = [];

  final List<Manga> _mangas = [];
  final List<Manga> _trendingMangas = [];

  List<Anime> get animes => _animes;
  List<Anime> get trendingAnimes => _trendingAnimes;
  List<Anime> get notAnimes => _animes.where((element) => trendingAnimes.indexWhere((trending) => element.id == trending.id) == -1).toList();

  List<Manga> get mangas => _mangas;
  List<Manga> get trendingMangas => _trendingMangas;
  List<Manga> get notMangas => _mangas.where((element) => trendingMangas.indexWhere((trending) => element.id == trending.id) == -1).toList();

  Future<void> fetchAnimeList() async {
    isLoading = true;
    notify();
    if (_trendingAnimes.length < 10) {
      _trendingAnimes.addAll((await _apiRepository.getTrendingAnimes()).animes);
    }
    _animes.addAll(List.generate(10, (index) => Anime.placeholder()));
    notify();
    final animesToAdd = (await _apiRepository.getAnimes(start: _animes.length + 1, end: 10));
    print(animesToAdd.animes);
    _animes.replaceRange(_animes.length - 10, _animes.length, animesToAdd.animes);

    if (_streamers.length < 11) {
      _streamers.addAll((await _apiRepository.getStreamers()).streamersList);
    }

    isLoading = false;
    notify();
  }

  Future<void> fetchMangaList() async {
    isLoading = true;
    notify();
    if (_trendingMangas.length < 10) {
      _trendingMangas.addAll((await _apiRepository.getTrendingMangas()).mangas);
    }
    _mangas.addAll(List.generate(10, (index) => Manga.placeholder()));
    notify();

    final response = await _apiRepository.getMangas(start: _mangas.length + 1, end: 10);

    _mangas.replaceRange(_mangas.length - 10, _mangas.length, response.mangas);

    isLoading = false;
    notify();
  }

  Future<List<Character>> fetchCharacterByAnime(String id) async {
    isLoading = true;
    if (_charactersByAnime[id] == null) {
      _charactersByAnime[id] = (await _apiRepository.getCharacters(id: id)).characters;
    }
    isLoading = false;
    notify();
    return _charactersByAnime[id]!;
  }

  Future<List<Streaming>> fetchStreamingByAnime(String id) async {
    isLoading = true;
    if (_streamingsAnime[id] == null) {
      _streamingsAnime[id] = (await _apiRepository.getStreamings(id: id)).streamings;
    }
    isLoading = false;
    notify();
    return _streamingsAnime[id]!;
  }

  Future<List<Manga>> searchManga(String name, {start = 1, end = 10}) async {
    List<Manga> result = (await _apiRepository.getMangas(search: name.trim(), start: start, end: end)).mangas;

    mangas.addAll(result.where((element) => mangas.where((anime) => anime.id == element.id).isEmpty).toList());

    return result;
  }

  Future<List<Anime>> searchAnime(String name) async {
    List<Anime> result = (await _apiRepository.getAnimes(search: name.trim())).animes;

    animes.addAll(result.where((element) => animes.where((anime) => anime.id == element.id).isEmpty).toList());

    return result;
  }

  Future<Anime?> getRandomAnime() async {
    int randomID = random.nextInt(18643);

    Anime? anime = (await _apiRepository.getAnime(randomID.toString())).anime;

    if (anime != null && !animes.contains(anime)) {
      animes.add(anime);
      notify();
    }

    return anime;
  }

  static GlobalProvider of(BuildContext context, {listen = true}) => Provider.of<GlobalProvider>(context, listen: listen);

  notify() {
    notifyListeners();
  }
}
