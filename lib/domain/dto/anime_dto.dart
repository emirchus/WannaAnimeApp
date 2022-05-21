import 'dart:convert';
import 'package:http/http.dart';
import 'package:wannaanime/domain/dto/dto.dart';
import 'package:wannaanime/domain/entities/anime.dart';

class AnimeDTO extends DTO {
  AnimeDTO({
    required statusCode,
    required message,
    data,
  }) : super(statusCode: statusCode, statusMessage: message, data: data);

  Anime? get anime => statusCode == 200 ? Anime.fromMap(json.decode(utf8.decode(data!))['data']) : null;

  factory AnimeDTO.fromResponse(Response response) => AnimeDTO(
        statusCode: response.statusCode,
        message: json.decode(response.body)?['errors']?[0]?['detail'] ?? "Message not found",
        data: response.bodyBytes,
      );
}
