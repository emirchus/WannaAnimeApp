import 'dart:typed_data';

abstract class DTO {
  int statusCode;
  String statusMessage;
  Uint8List? data;

  DTO({required this.statusCode, required this.statusMessage, this.data});


}
