import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wannaanime/common/colors_brightness.dart';
import 'package:wannaanime/domain/entities/character_entity.dart';
import 'package:wannaanime/presentation/widgets/scroll_behaviour.dart';


class CharacterBottomSheet extends StatelessWidget {

  final CharacterEntity character;
  final Color mainColor, secondaryColor;

  const CharacterBottomSheet({Key? key, required this.character, required this.mainColor, required this.secondaryColor}) : super(key: key);


  static void openModal(context, character, mainColor, secondaryColor) async {
    final size = MediaQuery.of(context).size;
    await showModalBottomSheet(
      context: context,
      backgroundColor: secondaryColor.withOpacity(1.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: size.height - (size.width * 9 / 16) + 50),
      builder: (context) => CharacterBottomSheet(
        character: character,
        mainColor: mainColor,
        secondaryColor: secondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox.fromSize(
      size: Size.fromHeight(size.height - (size.width * 9 / 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.width / 3,
            height: 5,
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: ScrollConfiguration(
              behavior: const NoGlowBehaviour(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Text(character.canonicalName, softWrap: false, style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: ColorBrightness.darken(mainColor, 0.3),
                      fontWeight: FontWeight.bold
                    ),),
                    Text((character.names?.values.whereType<String>() ?? []).join(' '), softWrap: false, style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: ColorBrightness.darken(mainColor, 0.3),
                      fontWeight: FontWeight.bold
                    ),),
                       Text((character.otherNames ?? []).join(' - '), softWrap: false, style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: ColorBrightness.darken(mainColor, 0.3),
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width / 3,
                          height: size.width / 3,
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
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(character.description, style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: ColorBrightness.darken(mainColor, 0.3),
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}