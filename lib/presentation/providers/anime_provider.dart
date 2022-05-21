import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:wannaanime/domain/entities/anime.dart';
import 'package:wannaanime/domain/entities/character.dart';

class AnimeProvider extends ChangeNotifier {
  static AnimeProvider of(BuildContext context, {listen = true}) => Provider.of(context, listen: listen);

  Anime? _anime;
  List<Character>? _characters;
  PaletteGenerator? _paletteGenerator;

  Anime? get anime => _anime;

  List<Character> get characters => _characters ?? [];

  set anime(Anime? anime) {
    _anime = anime;
    notifyListeners();
  }

  set characters(List<Character> characters) {
    _characters = characters;
    notifyListeners();
  }

  PaletteGenerator? get paletteGenerator {
    return _paletteGenerator;
  }

  set paletteGenerator(PaletteGenerator? paletteGenerator) {
    _paletteGenerator = paletteGenerator;
    notifyListeners();
  }

  void clear(){
    _anime = null;
    _characters = [];
    _paletteGenerator = null;
  }
}