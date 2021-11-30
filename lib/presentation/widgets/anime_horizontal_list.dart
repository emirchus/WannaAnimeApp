import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/presentation/widgets/anime_card.dart';


class AnimeHorizontalList extends StatelessWidget {

  final List<AnimeEntity> animes;

  const AnimeHorizontalList({Key? key, required this.animes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: animes.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: false,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        var anime = animes[index];
        return Animecard(anime: anime);
      },
    );
  }
}