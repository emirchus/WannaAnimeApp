import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wannaanime/application/common/colors_brightness.dart';
import 'package:wannaanime/domain/entities/anime.dart';
import 'package:wannaanime/domain/entities/character.dart';
import 'package:wannaanime/presentation/providers/anime_provider.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/ui/expand_image.dart';
import 'package:wannaanime/presentation/widgets/button.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/ui/banner.dart';
import 'package:wannaanime/presentation/ui/anime/anime_header.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';
import 'package:wannaanime/presentation/widgets/character_card.dart';
import 'package:wannaanime/presentation/widgets/scroll_behaviour.dart';
import 'package:wannaanime/presentation/ui/video_dialog.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class AnimeScreen extends StatefulWidget {
  const AnimeScreen({Key? key}) : super(key: key);

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {

  late Color mainColor = ColorBrightness.lighten(AppTheme.logoBlue, .4);
  late Color secondaryColor = ColorBrightness.darken(AppTheme.logoBlue, .4);
  late YoutubePlayerController playerController;
  final ScrollController scrollController = ScrollController();
  late GlobalProvider provider;
  late AnimeProvider animeProvider;

  @override
  void initState() {
    super.initState();
    provider = GlobalProvider.of(context, listen: false);
    animeProvider = AnimeProvider.of(context, listen: false);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      Anime anime = animeProvider.anime!;
      final colors = animeProvider.paletteGenerator;

      if(anime.id.isEmpty) {
        return Navigator.pop(context);
      }
      if(anime.youtubeVideoId != null){
        playerController= YoutubePlayerController(
          initialVideoId: anime.youtubeVideoId!,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        );
      }
      if(mounted){
        setState(() {
          mainColor = colors?.dominantColor?.color ?? ColorBrightness.lighten(AppTheme.logoBlue, .4);
          secondaryColor = colors?.dominantColor?.bodyTextColor ?? ColorBrightness.darken(AppTheme.logoBlue, .4);
        });
      }
    });
  }

  @override
  void dispose() {
    animeProvider.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Anime anime = animeProvider.anime!;
    context.watch<AnimeProvider>();


    final size = MediaQuery.of(context).size;
    final mainColorDark = ColorBrightness.darken(AppTheme.logoBlue, 1);
    return WillPopScope(
      onWillPop: () async {
        provider.headerColor = Colors.white;
        provider.homeScreenKey.currentState?.tabController.index = 0;
        provider.notify();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor.withOpacity(.4),
          iconTheme: IconThemeData(color: secondaryColor.withOpacity(1.0)),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
              provider.headerColor = Colors.white;
              provider.homeScreenKey.currentState?.tabController.index = 0;
              provider.notify();
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: mainColor,
        extendBody: true,
        body: SizedBox.fromSize(
          size: size,
          child: Stack(
            children: [
              Banners(background: mainColor, animeId: '${anime.canonicalTitle}${anime.id}', imageUrl: anime.posterImage, controller: scrollController),
              Positioned(
                top: (size.width * 9 / 16) - 50,
                width: size.width,
                height: size.height - (size.width * 9 / 16) + 50,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          stops: const [0, .2],
                          colors: [
                            mainColor.withOpacity(0),
                            mainColor.withOpacity(1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: ScrollConfiguration(
                  behavior: const NoGlowBehaviour(),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    children: [
                      AnimeHeader(anime: anime, mainColorDark: mainColorDark),
                      Text('Synopsis', style: Theme.of(context).textTheme.headline6!.copyWith(color: secondaryColor, fontWeight: FontWeight.w900)),
                      Text(anime.description, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: secondaryColor)),
                      const SizedBox(height: 20,),
                      if(anime.youtubeVideoId != null) ...[
                        Row(
                          children: [
                            ButtonComponent('Watch Trailer', Icons.play_arrow,
                              onTap: () => VideoDialog.openModal(context, controller: playerController, cover: anime.coverImage),
                              primary: secondaryColor,
                              secondary: mainColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                      ],
                      Text('Arts', style: Theme.of(context).textTheme.headline6!.copyWith(color: secondaryColor, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: size.width,
                        height: 100,
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => ExpandImage.show(context, anime.coverImage ?? anime.posterImage),
                                child: CachedImage(
                                  anime.coverImage ?? anime.posterImage,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text('Characters', style: Theme.of(context).textTheme.headline6!.copyWith(color: secondaryColor, fontWeight: FontWeight.bold)),
                      if (animeProvider.characters.isEmpty) Text('no characters found TwT', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: secondaryColor,
                      ),),
                      if (animeProvider.characters.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: animeProvider.characters.length,
                          itemBuilder: (context, index) {
                            Character characterEntity = animeProvider.characters[index];
                            return CharacterCard(
                              character: characterEntity,
                              mainColor: mainColor,
                              secondaryColor: secondaryColor,
                            );
                          },
                        )
                    ],
                  ),
                )
              ),
            ]
          ),
        )
      ),
    );
  }
}