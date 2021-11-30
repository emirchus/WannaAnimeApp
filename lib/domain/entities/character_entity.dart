import 'dart:convert';

class CharacterEntity {
  final String id;
  final String role; //

  final String canonicalName; //['included'][0]['attributes']['canonicalName']
  final String description; //['included'][0]['attributes']['description']
  final String? image; //['included'][0]['attributes']['image']['original']
  final Map<String, String>? names;
  final List<String>? otherNames;

  CharacterEntity({
    required this.id,
    required this.role,
    required this.canonicalName,
    required this.description,
    required this.image,
    required this.names,
    required this.otherNames,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'canonicalName': canonicalName,
      'description': description,
      'image': image,
    };
  }

  factory CharacterEntity.fromMap(Map<String, dynamic> map) {
    return CharacterEntity(
      id: map['id'],
      role:  '',
      canonicalName: map['attributes']['canonicalName'],
      names: (map['attributes']['names']..removeWhere((key, value) => value == null)).cast<String, String>(),
      otherNames: map['attributes']['otherNames'].cast<String>(),
      description: map['attributes']['description'],
      image: map['attributes']['image']?['original'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterEntity.fromJson(String source) => CharacterEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CharacterEntity(id: $id, role: $role, canonicalName: $canonicalName, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacterEntity &&
      other.id == id &&
      other.role == role &&
      other.canonicalName == canonicalName &&
      other.description == description &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      role.hashCode ^
      canonicalName.hashCode ^
      description.hashCode ^
      image.hashCode;
  }
}
