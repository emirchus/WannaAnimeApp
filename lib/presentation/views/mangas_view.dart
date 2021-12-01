import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/widgets/manga_card.dart';
import 'package:wannaanime/presentation/widgets/mangas_horizontal_list.dart';
import 'package:wannaanime/presentation/widgets/skeleton.dart';


class MangasView extends StatefulWidget {
  const MangasView({Key? key}) : super(key: key);

  @override
  State<MangasView> createState() => MangasViewState();
}

class MangasViewState extends State<MangasView> {
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
                  child: Text('Trending mangas', textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold
                  )),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 350,
                child: MangasHorizontalList(mangas: provider.trendingMangas),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Library mangas', textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5!.copyWith(
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
                  mainAxisSpacing: 20,
                ),
                itemCount: mangas.length,
                itemBuilder: (context, index) {
                  MangaEntity manga = mangas[index];
                  if(manga.placeholder){
                    return const Skeleton();
                  }
                  return MangaCard(manga: manga);
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