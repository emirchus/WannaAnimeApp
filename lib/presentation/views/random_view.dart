import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/src/provider.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/presentation/providers/anime_provider.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/ui/loading.dart';
import 'package:wannaanime/presentation/widgets/button.dart';
import 'package:wannaanime/presentation/widgets/lookea_icons.dart';


class RandomView extends StatefulWidget {
  const RandomView({Key? key}) : super(key: key);

  @override
  State<RandomView> createState() => RandomViewState();
}

class RandomViewState extends State<RandomView> {

  late GlobalProvider provider;
  late AnimeProvider animeProvider;

  @override
  void initState() {
    super.initState();
    provider = GlobalProvider.of(context, listen: false);
    animeProvider = AnimeProvider.of(context, listen: false);


    WidgetsBinding.instance!.addPostFrameCallback(rollAnime);
  }

  rollAnime(_) async {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    AnimeEntity? anime;
    PaletteGenerator? color;

    await Loading.show(context, () async {
      anime = await provider.getRandomAnime();
      if (anime == null) {
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.red,
          content: const Text(
            'Anime not found',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Try again',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                provider.homeScreenKey.currentState?.tabController.index = 2;
                provider.notify();
              },
            ),
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //Close Material Banner
                ScaffoldMessenger.of(provider.homeScreenKey.currentContext!).hideCurrentMaterialBanner();
              },
            ),
          ],
        ));
        provider.headerColor = Colors.white;
        provider.homeScreenKey.currentState?.tabController.index = 0;
        provider.notify();
        return;
      }

      color = await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(anime!.posterImage));
      provider.headerColor = color!.darkMutedColor!.color;
      animeProvider.anime = anime!;
      animeProvider.paletteGenerator = color!;
      provider.notify();
    });

    if(mounted){
      setState(() {});
    }
  }

  @override
  void dispose() {
    animeProvider.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AnimeProvider>();
    return animeProvider.anime != null ? Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: CachedNetworkImageProvider(animeProvider.anime!.posterImage),
              fit: BoxFit.cover,
            )
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: animeProvider.paletteGenerator?.lightMutedColor?.color.withOpacity(0.5),
            ),
          )
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(animeProvider.anime!.canonicalTitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: animeProvider.paletteGenerator!.dominantColor!.bodyTextColor,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              const SizedBox(height: 20),
              SizedBox.fromSize(
                size: const Size(200, 50),
                child: ButtonComponent('Go to anime', LookeaIcons.eye, primary: animeProvider.paletteGenerator!.darkMutedColor!.color, secondary: animeProvider.paletteGenerator!.darkMutedColor!.titleTextColor, onTap: () => Navigator.pushNamed(context, '/anime'),)
              ),
              const SizedBox(height: 50),
              SizedBox.fromSize(
                size: const Size(200, 50),
                child: ButtonComponent('Reroll', LookeaIcons.refresh, primary: animeProvider.paletteGenerator?.lightMutedColor?.color, secondary: animeProvider.paletteGenerator?.lightMutedColor?.titleTextColor, onTap: () => rollAnime(''),)
              ),
            ],
          )
        )
      ]
    ) : const Center(
      child: CircularProgressIndicator(),
    );
  }
}