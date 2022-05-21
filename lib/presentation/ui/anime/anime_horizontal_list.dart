import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/anime.dart';
import 'package:wannaanime/presentation/ui/anime/anime_card.dart';


class AnimeHorizontalList extends StatelessWidget {

  final List<Anime> animes;

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
        return Container(
          width: 280,
          height: 350,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Animecard(anime: anime)
        );
      },
    );
  }
}