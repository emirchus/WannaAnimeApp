import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:wannaanime/application/data/services/consumer.dart';
class DownloadImage {
  final String url;

  const DownloadImage(this.url);

  Future<File?> download() async {
    String path = await _bakeDirectory(url);

    File file = File(path);

    var response = await Consumer.fetch(url: url);

    if (response.statusCode != 200) return null;

    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

  Future<String> _bakeDirectory(String url) async {
    Uri uri = Uri.parse(url);
    String fileName = uri.pathSegments.last;
    Directory dir = await getApplicationDocumentsDirectory();

    return '${dir.path}/$fileName';
  }
}
