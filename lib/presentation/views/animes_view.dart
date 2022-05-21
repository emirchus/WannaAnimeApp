import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/src/provider.dart';
import 'package:wannaanime/presentation/providers/anime_provider.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/ui/anime/anime_horizontal_list.dart';
import 'package:wannaanime/presentation/ui/anime_search.dart';
import 'package:wannaanime/presentation/ui/loading.dart';
import 'package:wannaanime/presentation/widgets/horizontal_card.dart';
import 'package:wannaanime/presentation/widgets/lookea_icons.dart';
import 'package:wannaanime/presentation/widgets/skeleton.dart';

class AnimesView extends StatefulWidget {
  const AnimesView({Key? key}) : super(key: key);

  @override
  State<AnimesView> createState() => AnimesViewState();
}

class AnimesViewState extends State<AnimesView> with AutomaticKeepAliveClientMixin {
  late GlobalProvider provider;
  late AnimeProvider animeProvider;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = GlobalProvider.of(context, listen: false);
    animeProvider = AnimeProvider.of(context, listen: false);
    scrollController.addListener(onScroll);
  }

  void onScroll() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      provider.fetchAnimeList();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final animes = context.watch<GlobalProvider>().notAnimes;
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppTheme.logoBlue,
      onRefresh: () async {
        await provider.fetchAnimeList();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(bottom: 140),
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Trending animes', textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(width: double.infinity, height: 350, child: AnimeHorizontalList(animes: provider.trendingAnimes)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Library animes', textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                ),
                IconButton(
                  splashRadius: 15,
                  icon: const Icon(LookeaIcons.search),
                  onPressed: () async {
                    await showSearch(
                      context: context,
                      delegate: AnimeSearchDelegate(),
                    );
                  },
                ),
              ],
            ),
            ...animes.map(
              (anime) {
                if (anime.placeholder) {
                  return const Skeleton();
                }
                return HorizontalCard(
                  imageUrl: anime.posterImage,
                  title: anime.canonicalTitle,
                  description: anime.description,
                  onTap: () async {
                    animeProvider.anime = anime;
                    await Loading.show(context, () async {
                      animeProvider.paletteGenerator = await PaletteGenerator.fromImageProvider(
                        CachedNetworkImageProvider(anime.posterImage),
                      );
                      animeProvider.characters = await provider.fetchCharacterByAnime(anime.id);
                    });
                    Navigator.pushNamed(context, '/anime');
                  },
                );
              },
            ),
          ]),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
