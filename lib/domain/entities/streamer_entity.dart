import 'dart:convert';

class StreamerEntity {

  final String id;
  final String siteName;
  final int streamingLinksCount;

  StreamerEntity({
    required this.id,
    required this.siteName,
    required this.streamingLinksCount,
  });

  StreamerEntity copyWith({
    String? id,
    String? siteName,
    int? streamingLinksCount,
  }) {
    return StreamerEntity(
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

  factory StreamerEntity.fromMap(Map<String, dynamic> map) {
    return StreamerEntity(
      id: map['id'],
      siteName: map['attributes']['siteName'],
      streamingLinksCount: map['attributes']['streamingLinksCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StreamerEntity.fromJson(String source) => StreamerEntity.fromMap(json.decode(source));

  @override
  String toString() => 'StreamerEntity(id: $id, siteName: $siteName, streamingLinksCount: $streamingLinksCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StreamerEntity &&
      other.id == id &&
      other.siteName == siteName &&
      other.streamingLinksCount == streamingLinksCount;
  }

  @override
  int get hashCode => id.hashCode ^ siteName.hashCode ^ streamingLinksCount.hashCode;
}
