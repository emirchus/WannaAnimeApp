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
  List<String> abbreviatedTitles;
  String? averageRating;
  final int favoritesCount;
  final DateTime startDate;
  DateTime? endDate;
  DateTime? nextRelease;
  final int popularityRank;
  int? ratingRank;
  String? ageRating;
  String? ageRatingGuide;
  final String subtype;
  final String status;
  final String posterImage;
  String? coverImage;
  int? episodeCount;
  int? episodeLength;
  int? totalLength;
  String? youtubeVideoId;
  final String showType;
  final bool nsfw;

  final bool placeholder;

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
    this.averageRating,
    required this.favoritesCount,
    required this.startDate,
    required this.endDate,
    this.nextRelease,
    required this.popularityRank,
    this.ratingRank,
    this.ageRating,
    this.ageRatingGuide,
    required this.subtype,
    required this.status,
    required this.posterImage,
    this.coverImage,
    required this.episodeCount,
    this.episodeLength,
    this.totalLength,
    this.youtubeVideoId,
    required this.showType,
    required this.nsfw,
  }) : placeholder = false;

  AnimeEntity.placeholder() : id = '', type = '', createdAt = DateTime.now(), updatedAt = DateTime.now(), slug = '', synopsis = '', description = '', titles = {}, canonicalTitle = '', abbreviatedTitles = [], averageRating = '', favoritesCount = 0, startDate = DateTime.now(), endDate = null, nextRelease = null, popularityRank = 0, subtype = '', status = '', posterImage = '', coverImage = '', showType = '', nsfw = false, placeholder = true;

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
      titles: (map['attributes']['titles']..removeWhere((_, v) => v == null)).cast<String, String>(),
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
