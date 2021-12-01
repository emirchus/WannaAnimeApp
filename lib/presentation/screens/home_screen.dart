import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/ui/anime_search.dart';
import 'package:wannaanime/presentation/ui/manga_search.dart';
import 'package:wannaanime/presentation/views/home_view.dart';
import 'package:wannaanime/presentation/views/mangas_view.dart';
import 'package:wannaanime/presentation/views/random_view.dart';
import 'package:wannaanime/presentation/widgets/bottom_navbar.dart';
import 'package:wannaanime/presentation/widgets/lookea_icons.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(length: 3, vsync: this);
  final GlobalKey<HomeViewState> homeViewKey = GlobalKey<HomeViewState>();
  final GlobalKey<MangasViewState> mangasViewKey = GlobalKey<MangasViewState>();

  @override
  Widget build(BuildContext context) {
    GlobalProvider provider = GlobalProvider.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: provider.headerColor,
          child: SafeArea(
            top: true,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                if([0, 1].contains(tabController.index))const SizedBox(width: 24),
                Expanded(
                  flex: 8,
                  child: GestureDetector(
                    onTap: () {
                      if(tabController.index == 0) {
                        return homeViewKey.currentState?.scrollController.jumpTo(0);
                      }
                      if(tabController.index == 1){
                        return mangasViewKey.currentState?.scrollController.jumpTo(0);
                      }
                    } ,
                    child: const Center(
                      child: Image(
                        image: AssetImage('assets/images/logo-256.png'),
                        height: 30,
                      )
                    ),
                  ),
                ),
                if([0, 1].contains(tabController.index))
                  IconButton(
                    icon: const Icon(LookeaIcons.search),
                    onPressed: () async {
                      if(tabController.index == 0) {
                        await showSearch(
                          context: context,
                          delegate: AnimeSearchDelegate(),
                        );
                      }
                      else if(tabController.index == 1) {
                        await showSearch(
                          context: context,
                          delegate: MangaSearchDelegate(),
                        );
                      }
                    },
                  ),
                if(![0, 1].contains(tabController.index)) const SizedBox(width: 24),
              ],
            ),
          ),
        )
      ),
      bottomNavigationBar: Navbar(currentIndex: tabController.index, onChange: (index) async {
        if(index == 4){
          //TODO: Show about screen
          return;
        }
        if(index == 3){
          return await showSearch(context: context, delegate: AnimeSearchDelegate());
        }
        provider.headerColor = Colors.white;
        setState(() {});
        tabController.animateTo(index);
      }),
      extendBody: true,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeView(key: homeViewKey,),
          MangasView(key: mangasViewKey,),
          const RandomView()
        ],
      )
    );
  }
}