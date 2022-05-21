import 'package:wannaanime/domain/mixins/characters_usecase.dart';
import 'package:wannaanime/domain/repositories/animes_repository.dart';
import 'package:wannaanime/domain/repositories/mangas_repository.dart';
import 'package:wannaanime/domain/repositories/streaming_repository.dart';

abstract class ApiRepository with AnimesRepositoryMixin, CharacterUseCase, StreamingRepository, MangasRepository {}
