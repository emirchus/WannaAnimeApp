import 'dart:convert';
import 'dart:typed_data';

import 'package:wannaanime/domain/entities/streaming_entity.dart';

class StreamingsDTO {
  final int statusCode;
  final String message;
  final Uint8List? streamings;

  StreamingsDTO({
    required this.statusCode,
    required this.message,
    this.streamings,
  });
}

extension StreamingsMapper on StreamingsDTO {
  List<StreamingEntity>? toStreamings() {
    if (streamings == null) {
      return null;
    }
    var decode = json.decode(utf8.decode(streamings!));
    return decode['included'].map<StreamingEntity>((streaming) => StreamingEntity.fromMap(streaming)).toList();
  }
}
