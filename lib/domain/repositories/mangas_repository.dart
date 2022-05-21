import 'package:wannaanime/domain/dto/manga_dto.dart';

mixin MangasRepository {
  Future<MangasDTO> getMangas({int start = 1, int end = 20, String search = ''});

  Future<MangasDTO> getTrendingMangas();
}
