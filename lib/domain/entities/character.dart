import 'dart:convert';

import 'package:wannaanime/domain/dto/entity.dart';

class Character extends Entity {
  final String role; //

  final String canonicalName; //['included'][0]['attributes']['canonicalName']
  final String description; //['included'][0]['attributes']['description']
  final String? image; //['included'][0]['attributes']['image']['original']
  final Map<String, String>? names;
  final List<String>? otherNames;

  Character({
    required id,
    required this.role,
    required this.canonicalName,
    required this.description,
    required this.image,
    required this.names,
    required this.otherNames,
  }) : super(id);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'canonicalName': canonicalName,
      'description': description,
      'image': image,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'],
      role: '',
      canonicalName: map['attributes']['canonicalName'],
      names: (map['attributes']['names']..removeWhere((key, value) => value == null)).cast<String, String>(),
      otherNames: map['attributes']['otherNames'].cast<String>(),
      description: map['attributes']['description'],
      image: map['attributes']['image']?['original'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) => Character.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CharacterEntity(id: $id, role: $role, canonicalName: $canonicalName, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Character && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
