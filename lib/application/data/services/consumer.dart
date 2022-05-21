import 'package:http/http.dart' as http;

class Consumer {
  static Future<http.Response> fetch({required String url}) async {
    final uri = Uri.parse(url);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      },
    );
    return response;
  }
}
