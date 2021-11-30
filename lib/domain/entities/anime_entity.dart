import 'dart:convert';

class AnimeEntity {
  final String id;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String slug;
  final String synopsis;
  final String description;
  final Map<String, String> titles;
  final String canonicalTitle;
  final List<String> abbreviatedTitles;
  final String averageRating;
  final int favoritesCount;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? nextRelease;
  final int popularityRank;
  final int ratingRank;
  final String ageRating;
  final String? ageRatingGuide;
  final String subtype;
  final String status;
  final String posterImage;
  final String? coverImage;
  final int? episodeCount;
  final int? episodeLength;
  final int totalLength;
  final String? youtubeVideoId;
  final String showType;
  final bool nsfw;

  AnimeEntity({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.synopsis,
    required this.description,
    required this.titles,
    required this.canonicalTitle,
    required this.abbreviatedTitles,
    required this.averageRating,
    required this.favoritesCount,
    required this.startDate,
    required this.endDate,
    this.nextRelease,
    required this.popularityRank,
    required this.ratingRank,
    required this.ageRating,
    required this.ageRatingGuide,
    required this.subtype,
    required this.status,
    required this.posterImage,
    this.coverImage,
    required this.episodeCount,
    this.episodeLength,
    required this.totalLength,
    this.youtubeVideoId,
    required this.showType,
    required this.nsfw,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'slug': slug,
      'synopsis': synopsis,
      'description': description,
      'titles': titles,
      'canonicalTitle': canonicalTitle,
      'abbreviatedTitles': abbreviatedTitles,
      'averageRating': averageRating,
      'favoritesCount': favoritesCount,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'nextRelease': nextRelease,
      'popularityRank': popularityRank,
      'ratingRank': ratingRank,
      'ageRating': ageRating,
      'ageRatingGuide': ageRatingGuide,
      'subtype': subtype,
      'status': status,
      'posterImage': posterImage,
      'coverImage': coverImage,
      'episodeCount': episodeCount,
      'episodeLength': episodeLength,
      'totalLength': totalLength,
      'youtubeVideoId': youtubeVideoId,
      'showType': showType,
      'nsfw': nsfw,
    };
  }

  factory AnimeEntity.fromMap(Map<String, dynamic> map) {
    return AnimeEntity(
      id: map['id'],
      type: map['type'],
      createdAt: DateTime.parse(map['attributes']['createdAt']),
      updatedAt: DateTime.parse(map['attributes']['updatedAt']),
      slug: map['attributes']['slug'],
      synopsis: map['attributes']['synopsis'],
      description: map['attributes']['description'],
      titles: Map<String, String>.from(map['attributes']['titles']),
      canonicalTitle: map['attributes']['canonicalTitle'],
      abbreviatedTitles: List<String>.from(map['attributes']['abbreviatedTitles']),
      averageRating: map['attributes']['averageRating'],
      favoritesCount: map['attributes']['favoritesCount'],
      startDate: DateTime.parse(map['attributes']['startDate']),
      endDate: map['attributes']['endDate'] != null ? DateTime.parse(map['attributes']['endDate']) : null,
      nextRelease: map['attributes']['nextRelease'] != null ? DateTime.parse(map['attributes']['nextRelease']) : null,
      popularityRank: map['attributes']['popularityRank'],
      ratingRank: map['attributes']['ratingRank'],
      ageRating: map['attributes']['ageRating'],
      ageRatingGuide: map['attributes']['ageRatingGuide'],
      subtype: map['attributes']['subtype'],
      status: map['attributes']['status'],
      posterImage: map['attributes']['posterImage']['original'],
      coverImage: map['attributes']['coverImage']?['original'],
      episodeCount: map['attributes']['episodeCount'],
      episodeLength: map['attributes']['episodeLength'],
      totalLength: map['attributes']['totalLength'],
      youtubeVideoId: map['attributes']['youtubeVideoId'],
      showType: map['attributes']['showType'],
      nsfw: map['attributes']['nsfw'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeEntity.fromJson(String source) => AnimeEntity.fromMap(json.decode(source));
}
