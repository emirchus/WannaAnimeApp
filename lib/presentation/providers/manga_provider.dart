import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:wannaanime/domain/entities/manga.dart';

class MangaProvider extends ChangeNotifier {
  static MangaProvider of(BuildContext context, {listen = true}) => Provider.of<MangaProvider>(context, listen: listen);

  Manga? _manga;

  PaletteGenerator? palette;

  Manga get manga {
    return _manga ?? Manga(id: "", slug: "", synopsis: "", description: "", canonicalTitle: "", favoritesCount: 0, popularityRank: 0, imageUrl: '');
  }

  set manga(Manga value) {
    _manga = value;
    notifyListeners();
  }
}