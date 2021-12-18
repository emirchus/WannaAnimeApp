import 'dart:typed_data';

class ImageDTO {
  final int statusCode;
  final String message;
  final Uint8List? image;

  ImageDTO({
    required this.statusCode,
    required this.message,
    this.image,
  });
}