import 'package:wannaanime/domain/dto/streamers_dto.dart';
import 'package:wannaanime/domain/dto/streamings_dto.dart';

mixin StreamingRepository {
  Future<StreamersDTO> getStreamers();

  Future<StreamingsDTO> getStreamings({required String id});
}
