import 'dart:convert';

import 'package:wannaanime/domain/dto/entity.dart';

class Streamer extends Entity{

  final String siteName;
  final int streamingLinksCount;

  Streamer({
    required id,
    required this.siteName,
    required this.streamingLinksCount,
  }) : super(id);

  Streamer copyWith({
    String? id,
    String? siteName,
    int? streamingLinksCount,
  }) {
    return Streamer(
      id: id ?? this.id,
      siteName: siteName ?? this.siteName,
      streamingLinksCount: streamingLinksCount ?? this.streamingLinksCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'siteName': siteName,
      'streamingLinksCount': streamingLinksCount,
    };
  }

  factory Streamer.fromMap(Map<String, dynamic> map) {
    return Streamer(
      id: map['id'],
      siteName: map['attributes']['siteName'],
      streamingLinksCount: map['attributes']['streamingLinksCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Streamer.fromJson(String source) => Streamer.fromMap(json.decode(source));

  @override
  String toString() => 'StreamerEntity(id: $id, siteName: $siteName, streamingLinksCount: $streamingLinksCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Streamer &&
      other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
