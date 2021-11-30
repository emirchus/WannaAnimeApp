import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/ui/anime_search.dart';
import 'package:wannaanime/presentation/views/home_view.dart';
import 'package:wannaanime/presentation/widgets/anime_card.dart';
import 'package:wannaanime/presentation/widgets/anime_horizontal_list.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/widgets/bottom_navbar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    context.watch<GlobalProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('assets/images/logo-256.png'),
          height: 30,
        ),
      ),
      bottomNavigationBar: Navbar(currentIndex: tabController.index, onChange: (index) async {
        if(index == 4){
          //TODO: Show about screen
          return;
        }
        if(index == 1){
          return await showSearch(context: context, delegate: AnimeSearchDelegate());
        }
        setState(() {});
        tabController.animateTo(index);
      }),
      extendBody: true,
      body: TabBarView(
        controller: tabController,
        children: [
          HomeView(),
          Container(),
          Container()
        ],
      )
    );
  }
}