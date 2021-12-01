import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/widgets/anime_tile.dart';
import 'package:wannaanime/presentation/widgets/manga_tile.dart';
import 'package:wannaanime/presentation/widgets/scroll_behaviour.dart';


class MangaSearchDelegate extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon:const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
     return IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget> [
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    final provider = GlobalProvider.of(context, listen: false);

    return FutureBuilder<List<MangaEntity>>(
      future: provider.searchManga(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Column(
            children: const <Widget>[
              Text(
                "No Results Found.",
              ),
            ],
          );
        } else {
          var mangas = snapshot.data!;
          return ScrollConfiguration(
            behavior: const NoGlowBehaviour(),
            child: ListView.builder(
              itemCount: mangas.length,
              itemBuilder: (context, index) {
                final manga = mangas[index];
                return MangaTile(manga: manga);
              },
            ),
          );
        }
      }
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = GlobalProvider.of(context, listen: false);

    List<MangaEntity> mangas = [...provider.trendingMangas, ...provider.notMangas];

    return ListView.builder(
      itemCount: mangas.length,
      itemBuilder: (context, index) {
        final manga = mangas[index];

        return MangaTile(manga: manga);
      }
    );
  }
}