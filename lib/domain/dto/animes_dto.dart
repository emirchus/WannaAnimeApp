import 'dart:convert';
import 'package:http/http.dart';
import 'package:wannaanime/domain/dto/dto.dart';
import 'package:wannaanime/domain/entities/anime.dart';

class AnimesDTO extends DTO {
  AnimesDTO({
    required statusCode,
    required message,
    data,
  }) : super(statusCode: statusCode, statusMessage: message, data: data);

  List<Anime> get animes => statusCode == 200 ? List<Anime>.from(json.decode(utf8.decode(data!))['data'].map<Anime>((anime) => Anime.fromMap(anime)).toList()) : [];

  factory AnimesDTO.fromResponse(Response response) => AnimesDTO(
        statusCode: response.statusCode,
        message: json.decode(response.body)?['errors']?[0]?['detail'] ?? "Message not found",
        data: response.bodyBytes,
      );
}
