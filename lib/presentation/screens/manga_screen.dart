import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/src/provider.dart';
import 'package:wannaanime/common/colors_brightness.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/providers/manga_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/ui/banner.dart';
import 'package:wannaanime/presentation/ui/manga/manga_header.dart';
import 'package:wannaanime/presentation/widgets/scroll_behaviour.dart';


class MangaScreen extends StatefulWidget {
  const MangaScreen({Key? key}) : super(key: key);

  @override
  State<MangaScreen> createState() => _MangaScreenState();
}

class _MangaScreenState extends State<MangaScreen> {

  late Color mainColor = ColorBrightness.lighten(AppTheme.logoBlue, .4);
  late Color secondaryColor = ColorBrightness.darken(AppTheme.logoBlue, .4);
  final ScrollController scrollController = ScrollController();
  late GlobalProvider provider;
  late MangaProvider mangaProvider;

  @override
  void initState() {
    super.initState();
    provider = GlobalProvider.of(context, listen: false);
    mangaProvider = MangaProvider.of(context, listen: false);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      MangaEntity manga = mangaProvider.manga;
      final colors = mangaProvider.palette!;
      if(manga.id.isEmpty) {
        return Navigator.pop(context);
      }

      if(mounted){
        setState(() {
          mainColor = colors.dominantColor?.color ?? ColorBrightness.lighten(AppTheme.logoBlue, .4);
          secondaryColor = colors.dominantColor?.bodyTextColor ?? ColorBrightness.darken(AppTheme.logoBlue, .4);
        });

      }

    });
  }


  @override
  Widget build(BuildContext context) {
    MangaEntity manga = mangaProvider.manga;
    context.watch<MangaProvider>();

    final size = MediaQuery.of(context).size;
    final mainColorDark = ColorBrightness.darken(AppTheme.logoBlue, 1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: secondaryColor.withOpacity(1.0)),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: mainColor,
      extendBody: true,
      body: SizedBox.fromSize(
        size: size,
        child: Stack(
          children: [
            Banners(background: mainColor, animeId: '${manga.canonicalTitle}${manga.id}', imageUrl: manga.imageUrl, controller: scrollController),
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
                    MangaHeader(manga: manga, mainColorDark: mainColorDark),
                    Text('Synopsis', style: Theme.of(context).textTheme.headline6!.copyWith(color: secondaryColor, fontWeight: FontWeight.w900)),
                    Text(manga.description, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: secondaryColor)),

                  ],
                ),
              )
            ),
          ]
        ),
      )
   );
  }
}