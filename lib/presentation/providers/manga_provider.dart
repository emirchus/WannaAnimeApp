import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';

class MangaProvider extends ChangeNotifier {
  static MangaProvider of(BuildContext context, {listen = true}) => Provider.of<MangaProvider>(context, listen: listen);

  MangaEntity? _manga;

  MangaEntity get manga {
    return _manga ?? MangaEntity(id: "", slug: "", synopsis: "", description: "", canonicalTitle: "", favoritesCount: 0, popularityRank: 0, imageUrl: '');
  }

  set manga(MangaEntity value) {
    _manga = value;
    notifyListeners();
  }
}