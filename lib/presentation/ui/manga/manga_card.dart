import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wannaanime/common/colors_brightness.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/presentation/providers/manga_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/ui/loading.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';


class MangaCard extends StatelessWidget {

  final MangaEntity manga;

  const MangaCard({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mangaProvider = MangaProvider.of(context, listen: false);
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: child
      ),
      child: GestureDetector(
        onTap: () async {
          await Loading.show(context, () async {
            mangaProvider.manga = manga;
            mangaProvider.palette = await PaletteGenerator.fromImageProvider(
              CachedNetworkImageProvider(manga.imageUrl),
            );
          });
          Navigator.pushNamed(context, '/manga');
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
                tag: '${manga.canonicalTitle}${manga.id}',
                child: CachedImage(
                  manga.imageUrl,
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
                            Text(manga.canonicalTitle, textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.fade, softWrap: true, style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                            Expanded(
                              child: Text(manga.synopsis, textAlign: TextAlign.start, maxLines: 4, overflow: TextOverflow.fade, softWrap: true, style: Theme.of(context).textTheme.subtitle2!.copyWith(
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
      ),
    );
  }
}