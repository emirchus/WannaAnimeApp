import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wannaanime/application/common/download_image.dart';
import 'package:wannaanime/domain/entities/manga.dart';
import 'package:wannaanime/presentation/widgets/lookea_icons.dart';


class MangaHeader extends StatelessWidget {

  final Manga manga;
  final Color mainColorDark;

  const MangaHeader({Key? key, required this.manga, required this.mainColorDark}) : super(key: key);

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
                          child: Text(manga.canonicalTitle, softWrap: true, style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () async {
                              File? file = await DownloadImage(manga.imageUrl).download();
                              if(file == null) return;//TODO: ERROR LOG
                              await Share.shareFiles(
                                [
                                  file.path
                                ],
                                text: 'Hey! Check out this manga I found on WannaAnime!\n${manga.canonicalTitle}',
                                subject: manga.canonicalTitle,

                              );
                            },
                            icon: const Icon(LookeaIcons.share_alt, color: Colors.white,)
                          )
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () async {

                            },
                            icon: const Icon(LookeaIcons.download_alt, color: Colors.white,)
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Chapters: ${manga.chapterCount ?? 'N/A'}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Volumes: ${manga.volumeCount ?? 'N/A'}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Age: ${manga.ageRating ?? 'N/A'}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Rating: ${manga.ratingRank ?? 'N/A'}', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ]
                    ),
                    Center(
                      child: Text(manga.ageRatingGuide ?? '', textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white54, fontWeight: FontWeight.bold)),
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