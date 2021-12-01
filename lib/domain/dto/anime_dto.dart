import 'dart:convert';
import 'dart:typed_data';

import 'package:wannaanime/domain/entities/anime_entity.dart';

class AnimeDTO {
  final int statusCode;
  final String message;
  final Uint8List? anime;

  AnimeDTO({
    required this.statusCode,
    required this.message,
    this.anime,
  });
}

extension AnimeMapper on AnimeDTO {
  AnimeEntity? toEntity() {
    if (anime == null) return null;
    var decode = json.decode(utf8.decode(anime!));
    return AnimeEntity.fromMap(decode['data']);
  }
}
