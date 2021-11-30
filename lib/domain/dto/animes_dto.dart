import 'dart:convert';
import 'dart:typed_data';

import 'package:wannaanime/domain/entities/anime_entity.dart';

class AnimesDTO {
  final int statusCode;
  final String message;
  final Uint8List? animes;

  AnimesDTO({
    required this.statusCode,
    required this.message,
    this.animes,
  });
}

extension AnimesMapper on AnimesDTO {
  List<AnimeEntity>? toAnimes() {
    if (animes == null) {
      return null;
    }
    var decode = json.decode(utf8.decode(animes!));
    return decode['data'].map<AnimeEntity>((anime) => AnimeEntity.fromMap(anime)).toList();
  }
}
