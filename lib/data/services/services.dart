import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wannaanime/domain/dto/anime_dto.dart';
import 'package:wannaanime/domain/dto/animes_dto.dart';
import 'package:wannaanime/domain/dto/characters_dto.dart';
import 'package:wannaanime/domain/dto/manga_dto.dart';
import 'package:wannaanime/domain/dto/streamers_dto.dart';
import 'package:wannaanime/domain/dto/streamings_dto.dart';

class Services {
  static const String baseUrl = "https://kitsu.io/api/edge";

  static Future<AnimesDTO> getAnimes({int start = 1, int end = 20, String search = ''}) async {
    final uri = Uri.parse("$baseUrl/anime?page[limit]=$end&page[offset]=$start${search.isEmpty ? '' : '&filter[text]=$search'}");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      },
    );
    if (response.statusCode == 200) {
      return AnimesDTO(message: 'Animes fetches successfully', statusCode: 200, animes: response.bodyBytes);
    } else {
      dynamic resBody = json.decode(response.body);
      return AnimesDTO(message: resBody['errors'][0]['detail'], statusCode: response.statusCode);
    }
  }

  static Future<AnimesDTO> getTrendingAnimes({int start = 0, int end = 20}) async {
    final uri = Uri.parse("$baseUrl/trending/anime?page[limit]=$end&page[offset]=$start");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      },
    );
    if (response.statusCode == 200) {
      return AnimesDTO(message: 'Animes fetches successfully', statusCode: 200, animes: response.bodyBytes);
    } else {
      dynamic resBody = json.decode(response.body);
      return AnimesDTO(message: resBody['errors'][0]['detail'], statusCode: response.statusCode);
    }
  }

  static Future<CharactersDTO> getCharactersAnime(String id) async {
    final uri = Uri.parse("$baseUrl/anime/$id?include=animeCharacters.character&fields%5Banime%5D=id&fields%5BanimeCharacters%5D=role");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      },
    );
    if (response.statusCode == 200) {
      return CharactersDTO(message: 'Characters fetches successfully', statusCode: 200, characters: response.bodyBytes);
    } else {
      dynamic resBody = json.decode(response.body);
      return CharactersDTO(message: resBody['errors'][0]['detail'], statusCode: response.statusCode);
    }
  }

  static Future<StreamersDTO> getStreamers() async {
    final uri = Uri.parse("$baseUrl/streamers?page%5Boffset%5D=0&page%5Blimit%5D=20");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      },
    );
    if (response.statusCode == 200) {
      return StreamersDTO(message: 'Streamers fetched successfully', statusCode: 200, streamers: response.bodyBytes);
    } else {
      dynamic resBody = json.decode(response.body);
      return StreamersDTO(message: resBody['errors'][0]['detail'], statusCode: response.statusCode);
    }
  }

    static Future<StreamingsDTO> getStreamingFromAnime(String id) async {
    final uri = Uri.parse("$baseUrl/anime/$id?include=streamingLinks,%20&fields%5Banime%5D=id");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      },
    );
    if (response.statusCode == 200) {
      return StreamingsDTO(message: 'Characters fetches successfully', statusCode: 200, streamings: response.bodyBytes);
    } else {
      dynamic resBody = json.decode(response.body);
      return StreamingsDTO(message: resBody['errors'][0]['detail'], statusCode: response.statusCode);
    }
  }


  static Future<AnimeDTO> getAnime({required id}) async {
    final response = await http.get(Uri.parse('$baseUrl/anime/$id'));
    if (response.statusCode == 200) {
      return AnimeDTO(message: 'Animes fetches successfully', statusCode: 200, anime: response.bodyBytes);
    } else {
      dynamic resBody = json.decode(response.body);
      log(resBody['errors'][0]['detail']);
      return AnimeDTO(message: resBody['errors'][0]['detail'], statusCode: response.statusCode);
    }
  }

  static Future<MangasDTO> getMangas({int start = 1, int end = 20, String search = ''}) async {
    final uri = Uri.parse("$baseUrl/manga?page[limit]=$end&page[offset]=$start${search.isEmpty ? '' : '&filter[text]=$search'}");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      },
    );
    if (response.statusCode == 200) {
      return MangasDTO(message: 'Mangas fetches successfully', statusCode: 200, mangas: response.bodyBytes);
    } else {
      dynamic resBody = json.decode(response.body);
      return MangasDTO(message: resBody['errors'][0]['title'], statusCode: response.statusCode);
    }
  }

    static Future<MangasDTO> getTrendingMangas() async {
    final uri = Uri.parse("$baseUrl/trending/manga");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      },
    );
    if (response.statusCode == 200) {
      return MangasDTO(message: 'Mangas fetches successfully', statusCode: 200, mangas: response.bodyBytes);
    } else {
      dynamic resBody = json.decode(response.body);
      return MangasDTO(message: resBody['errors'][0]['title'], statusCode: response.statusCode);
    }
  }
}
