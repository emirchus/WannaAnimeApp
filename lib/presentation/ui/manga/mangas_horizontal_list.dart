import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/presentation/ui/manga/manga_card.dart';


class MangasHorizontalList extends StatelessWidget {

  final List<MangaEntity> mangas;

  const MangasHorizontalList({Key? key, required this.mangas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: mangas.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: false,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        var manga = mangas[index];
        return MangaCard(manga: manga);
      },
    );
  }
}