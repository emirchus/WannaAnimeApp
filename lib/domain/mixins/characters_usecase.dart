import 'package:wannaanime/domain/dto/characters_dto.dart';
mixin CharacterUseCase {
  Future<CharactersDTO> getCharacters({required String id});
}
