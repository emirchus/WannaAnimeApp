import 'dart:convert';
import 'dart:typed_data';

import 'package:wannaanime/domain/entities/streamer_entity.dart';

class StreamersDTO {
  final int statusCode;
  final String message;
  final Uint8List? streamers;

  StreamersDTO({
    required this.statusCode,
    required this.message,
    this.streamers,
  });
}

extension StreamersMapper on StreamersDTO {
  List<StreamerEntity>? toStreamers() {
    if (streamers == null) {
      return null;
    }
    var decode = json.decode(utf8.decode(streamers!));
    return decode['data'].map<StreamerEntity>((anime) => StreamerEntity.fromMap(anime)).toList();
  }
}
