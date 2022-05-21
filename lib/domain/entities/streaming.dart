import 'dart:convert';

import 'package:wannaanime/domain/dto/entity.dart';

class Streaming extends Entity {
  final DateTime createdAt; //['attributes']['createdAt']
  final DateTime updatedAt; //['attributes']['updatedAt']
  final String url; //['attributes']['updatedAt']
  final List<String> subs; //['attributes']['subs']
  final List<String> dubs; //['attributes']['dubs ']

  Streaming({
    required id,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.subs,
    required this.dubs,
  }) : super(id);

  Streaming copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? url,
    List<String>? subs,
    List<String>? dubs,
  }) {
    return Streaming(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      url: url ?? this.url,
      subs: subs ?? this.subs,
      dubs: dubs ?? this.dubs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'url': url,
      'subs': subs,
      'dubs': dubs,
    };
  }

  factory Streaming.fromMap(Map<String, dynamic> map) {
    return Streaming(
      id: map['id'],
      createdAt: DateTime.parse(map['attributes']['createdAt']),
      updatedAt: DateTime.parse(map['attributes']['updatedAt']),
      url: map['attributes']['url'],
      subs: List<String>.from(map['attributes']['subs']),
      dubs: List<String>.from(map['attributes']['dubs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Streaming.fromJson(String source) => Streaming.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StreamingEntity(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, url: $url, subs: $subs, dubs: $dubs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Streaming && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
