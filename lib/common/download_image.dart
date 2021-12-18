import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import 'package:wannaanime/data/services/services.dart';
import 'package:wannaanime/domain/dto/image_dto.dart';

class DownloadFile {
    static Future<File?> download(String url) async {

      String path = await _bakeDirectory(url);

      ImageDTO dto = await Services.getImage(url);

      if(dto.image == null) {
        return null;
      }

      File file = File(path);

      await file.writeAsBytes(dto.image!);


      return file;
    }

    static Future<String> _bakeDirectory(String url) async {
      Uri uri  = Uri.parse(url);
      String fileName = uri.pathSegments.last;
      Directory dir = await getApplicationDocumentsDirectory();

      return '${dir.path}/$fileName';
    }
}