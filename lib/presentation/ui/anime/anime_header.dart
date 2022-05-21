import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wannaanime/application/common/download_image.dart';
import 'package:wannaanime/domain/entities/anime.dart';
import 'package:wannaanime/presentation/widgets/lookea_icons.dart';
import 'package:intl/intl.dart';


class AnimeHeader extends StatelessWidget {

  final Anime anime;
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
                              File? file = await DownloadImage(anime.posterImage).download();
                              if(file == null) return;//TODO: ERROR LOG
                              await Share.shareFiles(
                                [
                                  file.path
                                ],
                                text: 'Hey! Check out this anime I found on WannaAnime!\n${anime.canonicalTitle}',
                                subject: anime.canonicalTitle,

                              );
                            },
                            icon: const Icon(LookeaIcons.share_alt, color: Colors.white,)
                          )
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(onPressed: (){}, icon: const Icon(LookeaIcons.download_alt, color: Colors.white,))
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(anime.episodeCount != null)
                          Text('Ep: ${NumberFormat.compact().format(anime.episodeCount)}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(NumberFormat.compact().format(anime.favoritesCount), style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                            const Icon(Icons.favorite, color: Colors.white, size: 14,)
                          ],
                        ),
                        if(anime.ageRating != null)
                          Text('Age: ${anime.ageRating}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        if(anime.averageRating != null)
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