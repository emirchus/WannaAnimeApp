import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/anime_entity.dart';
import 'package:wannaanime/presentation/providers/anime_provider.dart';
import 'package:wannaanime/presentation/providers/global_provider.dart';
import 'package:wannaanime/presentation/theme.dart';
import 'package:wannaanime/presentation/ui/loading.dart';
import 'package:wannaanime/presentation/widgets/cached_network_image.dart';


class AnimeTile extends StatelessWidget {

  final AnimeEntity anime;

  const AnimeTile({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animeProvider = AnimeProvider.of(context, listen: false);
    final globalProvider = GlobalProvider.of(context, listen: false);
    final subtitle = (anime.description.isEmpty ?  anime.synopsis : anime.description);
    return ListTile(
      title: Text(anime.canonicalTitle, style: Theme.of(context).textTheme.subtitle1!.copyWith(
        fontWeight: FontWeight.w900,
        color: AppTheme.primaryTextColor
      ),),
      subtitle: Text(subtitle.substring(0, subtitle.length > 100 ? 100 : subtitle.length), maxLines: 2, overflow: TextOverflow.fade, style: Theme.of(context).textTheme.subtitle2!.copyWith(
        fontWeight: FontWeight.w600,
        color: AppTheme.secondaryTextColor
      ),),
      leading: CachedImage(anime.posterImage, width: 50, height: 50, radius: 10, fit: BoxFit.cover,),
      onTap: () async {
        animeProvider.anime = anime;
        await Loading.show(context, () async {
          animeProvider.characters = await globalProvider.fetchCharacterByAnime(anime.id);
        });
        Navigator.popAndPushNamed(context, '/anime');
      },
    );
  }
}