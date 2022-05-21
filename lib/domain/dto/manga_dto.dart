import 'dart:convert';

import 'package:http/http.dart';
import 'package:wannaanime/domain/dto/dto.dart';
import 'package:wannaanime/domain/entities/manga.dart';

class MangasDTO extends DTO {
  MangasDTO({
    required statusCode,
    required message,
    data,
  }) : super(statusCode: statusCode, statusMessage: message, data: data);

  List<Manga> get mangas => statusCode == 200  ? json.decode(utf8.decode(data!))['data'].map<Manga>((manga) => Manga.fromMap(manga)).toList() : [];

  factory MangasDTO.fromResponse(Response response) => MangasDTO(
        statusCode: response.statusCode,
        message: json.decode(response.body)?['errors']?[0]?['detail'] ?? "Message not found",
        data: response.bodyBytes,
      );
}
