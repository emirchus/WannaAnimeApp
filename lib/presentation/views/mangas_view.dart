import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/src/provider.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/providers/manga_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/ui/loading.dart';
import 'package:wannaanime/presentation/ui/manga/mangas_horizontal_list.dart';
import 'package:wannaanime/presentation/ui/manga_search.dart';
import 'package:wannaanime/presentation/widgets/horizontal_card.dart';
import 'package:wannaanime/presentation/widgets/lookea_icons.dart';
import 'package:wannaanime/presentation/widgets/skeleton.dart';

class MangasView extends StatefulWidget {
  const MangasView({Key? key}) : super(key: key);

  @override
  State<MangasView> createState() => MangasViewState();
}

class MangasViewState extends State<MangasView> with AutomaticKeepAliveClientMixin {
  late GlobalProvider provider;
  late MangaProvider mangaProvider;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = GlobalProvider.of(context, listen: false);
    mangaProvider = MangaProvider.of(context, listen: false);

    scrollController.addListener(onScroll);
  }

  void onScroll() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      provider.fetchMangaList();
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
    final mangas = context.watch<GlobalProvider>().notMangas;
    super.build(context);
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppTheme.logoBlue,
      onRefresh: () async {
        await provider.fetchMangaList();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(bottom: 140),
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Trending mangas', textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 350,
                child: MangasHorizontalList(mangas: provider.trendingMangas),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Library mangas', textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LookeaIcons.search),
                    onPressed: () async {
                      await showSearch(
                        context: context,
                        delegate: MangaSearchDelegate(),
                      );
                    },
                  ),
                ],
              ),
              ...mangas.map((manga) {
                if (manga.placeholder) {
                  return const Skeleton();
                }
                return HorizontalCard(
                  imageUrl: manga.imageUrl,
                  title: manga.canonicalTitle,
                  description: manga.description,
                  onTap: () async {
                    await Loading.show(context, () async {
                      mangaProvider.manga = manga;
                      mangaProvider.palette = await PaletteGenerator.fromImageProvider(
                        CachedNetworkImageProvider(manga.imageUrl),
                      );
                    });
                    Navigator.pushNamed(context, '/manga');
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
