import 'dart:convert';

import 'package:http/http.dart';
import 'package:wannaanime/domain/dto/dto.dart';
import 'package:wannaanime/domain/entities/character.dart';

class CharactersDTO extends DTO {
  CharactersDTO({
    required statusCode,
    required message,
    data,
  }) : super(statusCode: statusCode, statusMessage: message, data: data);

  List<Character> get characters => statusCode == 200 ? json.decode(utf8.decode(data!))['included'].where((r) => r['type'] == 'characters').toList().map<Character>((character) => Character.fromMap(character)).toList() : [];

  factory CharactersDTO.fromResponse(Response response) => CharactersDTO(
        statusCode: response.statusCode,
        message: json.decode(response.body)?['errors']?[0]?['detail'] ?? "Message not found",
        data: response.bodyBytes,
      );
}
