import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/manga_entity.dart';
import 'package:wannaanime/presentation/providers/manga_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';


class MangaTile extends StatelessWidget {

  final MangaEntity manga;

  const MangaTile({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mangaProvider = MangaProvider.of(context, listen: false);
    final subtitle = (manga.description.isEmpty ?  manga.synopsis : manga.description);
    return ListTile(
      title: Text(manga.canonicalTitle, style: Theme.of(context).textTheme.subtitle1!.copyWith(
        fontWeight: FontWeight.w900,
        color: AppTheme.primaryTextColor
      ),),
      subtitle: Text(subtitle.substring(0, subtitle.length > 100 ? 100 : subtitle.length), maxLines: 2, overflow: TextOverflow.fade, style: Theme.of(context).textTheme.subtitle2!.copyWith(
        fontWeight: FontWeight.w600,
        color: AppTheme.secondaryTextColor
      ),),
      leading: CachedImage(manga.imageUrl, width: 50, height: 50, radius: 10, fit: BoxFit.cover,),
      onTap: () async {
        mangaProvider.manga = manga;
        Navigator.popAndPushNamed(context, '/manga');
      },
    );
  }
}