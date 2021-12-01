import 'dart:convert';
import 'dart:typed_data';

import 'package:wannaanime/domain/entities/manga_entity.dart';

class MangasDTO {
  final int statusCode;
  final String message;
  final Uint8List? mangas;

  MangasDTO({
    required this.statusCode,
    required this.message,
    this.mangas,
  });
}

extension MangasMapper on MangasDTO {
  List<MangaEntity>? toMangas() {
    if (mangas == null) {
      return null;
    }
    var decode = json.decode(utf8.decode(mangas!));
    return decode['data'].map<MangaEntity>((manga) => MangaEntity.fromMap(manga)).toList();
  }
}
