import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/ui/anime_search.dart';
import 'package:wannaanime/presentation/ui/manga_search.dart';
import 'package:wannaanime/presentation/views/animes_view.dart';
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
  final GlobalKey<AnimesViewState> homeViewKey = GlobalKey<AnimesViewState>();
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
                Expanded(
                  flex: 8,
                  child: provider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (tabController.index == 0) {
                              return homeViewKey.currentState?.scrollController.jumpTo(0);
                            }
                            if (tabController.index == 1) {
                              return mangasViewKey.currentState?.scrollController.jumpTo(0);
                            }
                          },
                          child: const Center(
                            child: Image(image: AssetImage('assets/images/logo-256.png'), height: 30),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Navbar(
        currentIndex: tabController.index,
        onChange: (index) async {
          if (index == 4) {
            //TODO: Show about screen
            return;
          }
          if (index == 3) {
            return await showSearch(context: context, delegate: AnimeSearchDelegate());
          }
          provider.headerColor = Colors.white;
          setState(() {});
          tabController.animateTo(index);
        },
      ),
      extendBody: true,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          AnimesView(
            key: homeViewKey,
          ),
          MangasView(
            key: mangasViewKey,
          ),
          const RandomView()
        ],
      ),
    );
  }
}
