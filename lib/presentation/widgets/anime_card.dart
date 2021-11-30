import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wannaanime/common/colors_brightness.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/presentation/providers/anime_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';


class Animecard extends StatelessWidget {

  final AnimeEntity anime;

  const Animecard({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animeProvider = AnimeProvider.of(context, listen: false);

    return GestureDetector(
      onTap: () {
        animeProvider.anime = anime;
        Navigator.pushNamed(context, '/anime');
      },
      child: Container(
        width: 280,
        height: 350,
        decoration: BoxDecoration(
          color: ColorBrightness.lighten(AppTheme.logoRed, .2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Hero(
              tag: '${anime.canonicalTitle}${anime.id}',
              child: CachedImage(
                anime.posterImage,
                fit: BoxFit.cover,
                width: 280,
                height: 350,
                radius: 20,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              width: 250,
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 250,
                    height: 130,
                    decoration: BoxDecoration(
                      color: ColorBrightness.darken(AppTheme.logoBlue, .4).withOpacity(.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(anime.canonicalTitle, textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.fade, softWrap: true, style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                          Expanded(
                            child: Text(anime.synopsis, textAlign: TextAlign.start, maxLines: 4, overflow: TextOverflow.fade, softWrap: true, style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            )),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              )
            )
          ],
        )
      ),
    );
  }
}