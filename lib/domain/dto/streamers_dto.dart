import 'dart:convert';
import 'package:http/http.dart';
import 'package:wannaanime/domain/dto/dto.dart';
import 'package:wannaanime/domain/entities/streamer.dart';

class StreamersDTO extends DTO {
  StreamersDTO({
    required statusCode,
    required message,
    data,
  }) : super(statusCode: statusCode, statusMessage: message, data: data);

  List<Streamer> get streamersList => statusCode == 200 ? (json.decode(utf8.decode(data!))['data'] as List<dynamic>).map((e) => Streamer.fromMap(e)).toList() : [];

  factory StreamersDTO.fromResponse(Response response) => StreamersDTO(
        statusCode: response.statusCode,
        message: json.decode(response.body)?['errors']?[0]?['detail'] ?? "Message not found",
        data: response.bodyBytes,
      );
}
