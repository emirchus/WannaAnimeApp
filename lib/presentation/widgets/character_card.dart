import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wannaanime/domain/entities/character_entity.dart';
import 'package:wannaanime/presentation/ui/character_bottomsheet.dart';


class CharacterCard extends StatelessWidget {

  final CharacterEntity character;
  final Color mainColor, secondaryColor;

  const CharacterCard({Key? key, required this.character, required this.mainColor, required this.secondaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CharacterBottomSheet.openModal(context, character, mainColor, secondaryColor);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
                image: character.image != null ? DecorationImage(
                  image: CachedNetworkImageProvider(character.image!),
                  fit: BoxFit.cover,
                ) : null,
              ),
              child: character.image == null ? Center(
                child: Icon(Icons.person, color: mainColor, size: 50,),
              ) : const SizedBox(),
            ),
          ),
          Text(character.canonicalName, maxLines: 1, overflow: TextOverflow.fade, softWrap: false, style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold, color: secondaryColor),),
        ]
      ),
    );
  }
}