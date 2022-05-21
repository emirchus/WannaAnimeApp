
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wannaanime/domain/entities/anime.dart';
import 'package:wannaanime/presentation/providers/anime_provider.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/ui/loading.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';


class Animecard extends StatelessWidget {

  final Anime anime;
  final bool minimal;

  const Animecard({Key? key, required this.anime, this.minimal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animeProvider = AnimeProvider.of(context, listen: false);
    final globalProvider = GlobalProvider.of(context, listen: false);
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: child
      ),
      child: GestureDetector(
        onTap: () async {
          animeProvider.anime = anime;
          await Loading.show(context, () async {
            animeProvider.paletteGenerator = await PaletteGenerator.fromImageProvider(
              CachedNetworkImageProvider(anime.posterImage),
            );
            animeProvider.characters = await globalProvider.fetchCharacterByAnime(anime.id);
          });
          Navigator.pushNamed(context, '/anime');
        },
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              height: 180,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(top: minimal ? 125 : 50),
                  decoration: BoxDecoration(
                    color: const Color(0xffe8e8e8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(10, 10),
                      )
                    ]

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 10),
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(anime.canonicalTitle, textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.fade, softWrap: !minimal, style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                        if(minimal == false)
                          Expanded(
                            child: Text(anime.synopsis, textAlign: TextAlign.start, maxLines: 4, overflow: TextOverflow.fade, softWrap: true, style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                          ),
                      ],
                    )
                  ),
                ),
              )
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: '${anime.canonicalTitle}${anime.id}',
                child: CachedImage(
                  anime.posterImage,
                  fit: BoxFit.cover,
                  width: minimal ? 150 : 250,
                  height: 215,
                  radius: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}