import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';


class AnimeHeader extends StatelessWidget {

  final AnimeEntity anime;
  final Color mainColorDark;

  const AnimeHeader({Key? key, required this.anime, required this.mainColorDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(top: (size.width * 9 / 16) - 20, bottom: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                color: mainColorDark.withOpacity(.2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(anime.canonicalTitle, style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () async {
                              await Share.share(anime.canonicalTitle + '\n', subject: anime.canonicalTitle);
                            },
                            icon: const Icon(Icons.share, color: Colors.white,)
                          )
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border, color: Colors.white,))
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Episodes: ${anime.episodeCount ?? 'N/A'}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${anime.favoritesCount}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                            const Icon(Icons.favorite, color: Colors.white, size: 14,)
                          ],
                        ),
                        Text('Age: ${anime.ageRating}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Rating: ${anime.averageRating}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Center(
                      child: Text(anime.ageRatingGuide ?? '', textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white54, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          )
        )
      );
  }
}