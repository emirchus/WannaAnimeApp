import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/ui/manga/manga_tile.dart';
import 'package:wannaanime/presentation/widgets/loader_list.dart';
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

    return LoaderList<MangaEntity>(
      future: (start, end) async {
        List<MangaEntity> list = await provider.searchManga(query,start: start+1, end: end);
        return list;
      },
      onData: (data) => {
        provider.notify()
      },
      builder: (context, manga) {
        return MangaTile(manga: manga);
      },
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