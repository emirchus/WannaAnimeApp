
import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/anime.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/ui/anime/anime_tile.dart';
import 'package:wannaanime/presentation/widgets/scroll_behaviour.dart';


class AnimeSearchDelegate extends SearchDelegate {

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

    return FutureBuilder<List<Anime>>(
      future: provider.searchAnime(query),
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
          var animes = snapshot.data!;
          return ScrollConfiguration(
            behavior: const NoGlowBehaviour(),
            child: ListView.builder(
              itemCount: animes.length,
              itemBuilder: (context, index) {
                final anime = animes[index];
                return AnimeTile(anime: anime);
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

    List<Anime> animes = [...provider.trendingAnimes, ...provider.notAnimes];

    return ListView.builder(
      itemCount: animes.length,
      itemBuilder: (context, index) {
        final anime = animes[index];

        return AnimeTile(anime: anime);
      }
    );
  }
}