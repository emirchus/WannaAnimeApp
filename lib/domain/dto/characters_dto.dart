import 'dart:convert';
import 'dart:typed_data';

import 'package:wannaanime/domain/entities/character_entity.dart';

class CharactersDTO {
  final int statusCode;
  final String message;
  final Uint8List? characters;

  CharactersDTO({
    required this.statusCode,
    required this.message,
    this.characters,
  });
}

extension CharactersMapper on CharactersDTO {
  List<CharacterEntity>? toCharacters() {
    if (characters == null) {
      return null;
    }
    var decode = json.decode(utf8.decode(characters!));
    return decode['included']?.where((r) => r['type'] == 'characters').toList().map<CharacterEntity>((character) => CharacterEntity.fromMap(character)).toList();
  }
}
