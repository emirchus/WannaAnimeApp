import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wannaanime/data/sources/api_repository_impl.dart';
import 'package:wannaanime/presentation/providers/anime_provider.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/providers/manga_provider.dart';

class Injector extends StatelessWidget {
  final Widget? router;

  const Injector({Key? key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalProvider>(create: (_) => GlobalProvider(ApiRepositoryImpl())),
        ChangeNotifierProvider<AnimeProvider>(create: (_) => AnimeProvider(),),
        ChangeNotifierProvider<MangaProvider>(create: (_) => MangaProvider(),)
      ],
      child: router,
    );
  }
}
