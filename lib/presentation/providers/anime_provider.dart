import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/domain/entities/character_entity.dart';

class AnimeProvider extends ChangeNotifier {
  static AnimeProvider of(BuildContext context, {listen = true}) => Provider.of(context, listen: listen);

  AnimeEntity? _anime;
  List<CharacterEntity>? _characters;

  AnimeEntity get anime {
    return _anime ?? AnimeEntity(id: "", type: "", createdAt: DateTime.now(), updatedAt: DateTime.now(), slug: "", synopsis: "", description: "", titles: {}, canonicalTitle: "", abbreviatedTitles: [], favoritesCount: 0, startDate: DateTime.now(), endDate: DateTime.now(), popularityRank: 0, subtype: "", status: "", posterImage: "", episodeCount: 0, showType: "", nsfw: false);
  }

  List<CharacterEntity> get characters => _characters ?? [];

  set anime(AnimeEntity anime) {
    _anime = anime;
    notifyListeners();
  }

  set characters(List<CharacterEntity> characters) {
    _characters = characters;
    notifyListeners();
  }

}