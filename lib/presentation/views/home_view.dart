import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/widgets/anime_card.dart';
import 'package:wannaanime/presentation/widgets/anime_horizontal_list.dart';


class HomeView extends StatefulWidget {

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GlobalProvider provider;
  final ScrollController scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    provider = GlobalProvider.of(context, listen: false);

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
                  child: Text('Trending animes', textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold
                  )),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 350,
                child: AnimeHorizontalList(animes: provider.trendingAnimes)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Library animes', textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold
                  )),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 250,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: provider.notAnimes.length,
                itemBuilder: (context, index) {
                  AnimeEntity anime = provider.notAnimes[index];
                  return Animecard(anime: anime);
                },
              ),
              if(provider.isLoading)
                const Center(child: CircularProgressIndicator())
            ]
          ),
        ),
      ),
    );
  }
}