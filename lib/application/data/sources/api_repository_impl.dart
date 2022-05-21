import 'package:wannaanime/application/data/services/consumer.dart';
import 'package:wannaanime/domain/dto/anime_dto.dart';
import 'package:wannaanime/domain/dto/animes_dto.dart';
import 'package:wannaanime/domain/dto/characters_dto.dart';
import 'package:wannaanime/domain/dto/manga_dto.dart';
import 'package:wannaanime/domain/dto/streamers_dto.dart';
import 'package:wannaanime/domain/dto/streamings_dto.dart';
import 'package:wannaanime/domain/repositories/api_repository.dart';

class ApiRepositoryImpl extends ApiRepository {
  static const String baseUrl = "https://kitsu.io/api/edge";

  @override
  Future<AnimesDTO> getAnimes({int start = 1, int end = 20, String search = ''}) async {
    final response = await Consumer.fetch(
      url: "$baseUrl/anime?page[limit]=$end&page[offset]=$start&${search.isNotEmpty ? 'filter[text]=$search' : ''}",
    );

    print(response.body);

    return AnimesDTO.fromResponse(response);
  }

  @override
  Future<AnimesDTO> getTrendingAnimes({int start = 0, int end = 20}) async {
    final response = await Consumer.fetch(url: "$baseUrl/trending/anime?page[limit]=$end&page[offset]=$start");

    return AnimesDTO.fromResponse(response);
  }

  @override
  Future<StreamersDTO> getStreamers() async {
    final aresponse = await Consumer.fetch(url: "$baseUrl/streamers?page%5Boffset%5D=0&page%5Blimit%5D=20");

    return StreamersDTO.fromResponse(aresponse);
  }

  @override
  Future<AnimeDTO> getAnime(String query) async {
    final response = await Consumer.fetch(url: "$baseUrl/anime/$query");
    return AnimeDTO.fromResponse(response);
  }

  @override
  Future<MangasDTO> getMangas({int start = 1, int end = 20, String search = ''}) async {
    final response = await Consumer.fetch(url: "$baseUrl/manga?page[limit]=$end&page[offset]=$start${search.isEmpty ? '' : '&filter[text]=$search'}");

    return MangasDTO.fromResponse(response);
  }

  @override
  Future<MangasDTO> getTrendingMangas() async {
    final response = await Consumer.fetch(url: "$baseUrl/trending/manga");

    return MangasDTO.fromResponse(response);
  }

  @override
  Future<CharactersDTO> getCharacters({required String id}) async {
    final response = await Consumer.fetch(url: "$baseUrl/anime/$id?include=animeCharacters.character&fields%5Banime%5D=id&fields%5BanimeCharacters%5D=role");

    return CharactersDTO.fromResponse(response);
  }

  @override
  Future<StreamingsDTO> getStreamings({required String id}) async {
    final response = await Consumer.fetch(url: "$baseUrl/anime/$id?include=streamingLinks,%20&fields%5Banime%5D=id");

    return StreamingsDTO.fromResponse(response);
  }
}
