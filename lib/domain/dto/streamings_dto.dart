import 'dart:convert';

import 'package:http/http.dart';
import 'package:wannaanime/domain/dto/dto.dart';
import 'package:wannaanime/domain/entities/streaming.dart';

class StreamingsDTO extends DTO {
  StreamingsDTO({
    required statusCode,
    required message,
    data,
  }) : super(statusCode: statusCode, statusMessage: message, data: data);

  List<Streaming> get streamings => statusCode == 200 ? json.decode(utf8.decode(data!))['included'].map<Streaming>((streaming) => Streaming.fromMap(streaming)).toList() : [];

  factory StreamingsDTO.fromResponse(Response response) => StreamingsDTO(statusCode: response.statusCode, message: json.decode(response.body)?['errors']?[0]?['detail'] ?? "Message not found", data: response.bodyBytes);
}
